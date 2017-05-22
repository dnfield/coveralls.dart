part of coveralls;

/// Uploads code coverage reports to the [Coveralls](https://coveralls.io) service.
class Client {

  /// The URL of the default API end point.
  static final Uri defaultEndPoint = Uri.parse('https://coveralls.io');

  /// Creates a new client.
  Client([endPoint]) {
    if (endPoint != null) endPoint = endPoint is Uri ? endPoint : Uri.parse(endPoint.toString());
  }

  /// The URL of the API end point.
  Uri endPoint = defaultEndPoint;

  /// The stream of "request" events.
  Stream<MultipartRequest> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<Response> get onResponse => _onResponse.stream;

  /// The handler of "request" events.
  final StreamController<MultipartRequest> _onRequest = new StreamController<MultipartRequest>.broadcast();

  /// The handler of "response" events.
  final StreamController<Response> _onResponse = new StreamController<Response>.broadcast();

  /// Uploads the specified code [coverage] report to the Coveralls service.
  /// A [configuration] object provides the environment settings.
  ///
  /// Throws an [FormatException] if the specified coverage report is empty, or if its format is not supported.
  Future upload(String coverage, [Configuration configuration]) async {
    assert(coverage != null);

    var report = coverage.trim();
    if (report.isEmpty) throw new FormatException('The specified coverage report is empty.');

    var token = report.substring(0, 3);
    if (token != '${Token.testName}:' && token != '${Token.sourceFile}:')
      throw new FormatException('The specified coverage format is not supported.', report);

    var results = await Future.wait([
      _parseReport(report),
      configuration != null ? new Future.value(configuration) : Configuration.loadDefaults(),
      which('git', orElse: () => '')
    ]);

    var job = results.first;
    _updateJob(job, results[1]);
    if (!job.runAt) job.runAt = new DateTime.now();

    if (results[2].isNotEmpty) {
      var git = await GitData.fromRepository();
      var branch = job.git != null ? job.git.branch : '';
      if (git.branch == 'HEAD' && branch.isNotEmpty) git.branch = branch;
      job.git = git;
    }

    return uploadJob(job);
  }

  /// Uploads the specified [job] to the Coveralls service.
  ///
  /// Throws an [ArgumentError] if the job does not meet the requirements.
  /// Throws a [HttpException] if the remote service does not respond successfully.
  Future uploadJob(Job job) async {
    assert(job != null);
    if (job.repoToken.isEmpty && job.serviceName.isEmpty)
      throw new ArgumentError.value(job, 'job', 'The job does not meet the requirements.');

    var request = new MultipartRequest('POST', endPoint.resolve('/api/v1/jobs'));
    request.files.add(new MultipartFile.fromString('json_file', JSON.encode(job), filename: 'coveralls.json'));
    _onRequest.add(request);

    var streamedResponse = await request.send();
    var response = await Response.fromStream(streamedResponse);
    _onResponse.add(response);

    if (response.statusCode != 200)
      throw new HttpException('${response.statusCode} ${response.reasonPhrase}', uri: request.url);
  }

  /// Parses the specified [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage [report].
  Future<Job> _parseReport(String report) async {
    var sourceFiles = <SourceFile>[];
    for (var record in Report.parse(report).records) {
      var source;
      try { source = await new File(record.sourceFile).readAsString(); }
      catch (e) { throw new FileSystemException('Source file not found.', record.sourceFile); }

      var lines = source.split(new RegExp(r'\r?\n'));
      var coverage = new List<int>(lines.length);
      for (var lineData in record.lines.data) coverage[lineData.lineNumber - 1] = lineData.executionCount;

      var filename = path.relative(record.sourceFile);
      var digest = md5.convert(source.codeUnits).toString();
      sourceFiles.add(new SourceFile(filename, digest, source, coverage));
    }

    return new Job(sourceFiles);
  }

  /// Updates the properties of the specified [job] using the given configuration parameters.
  void _updateJob(Job job, Configuration config) {
    if (config.containsKey('repo_token')) job.repoToken = config['repo_token'];
    else if (config.containsKey('repo_secret_token')) job.repoToken = config['repo_secret_token'];

    if (config.containsKey('parallel')) job.isParallel = config['parallel'] == 'true';
    if (config.containsKey('run_at')) job.runAt = DateTime.parse(config['run_at']);
    if (config.containsKey('service_job_id')) job.serviceJobId = config['service_job_id'];
    if (config.containsKey('service_name')) job.serviceName = config['service_name'];
    if (config.containsKey('service_number')) job.serviceNumber = config['service_number'];
    if (config.containsKey('service_pull_request')) job.servicePullRequest = config['service_pull_request'];

    var hasGitData = config.keys.any((key) => key == 'service_branch' || key.substring(0, 4) == 'git_');
    if (!hasGitData) job.commitSha = config['commit_sha'] ?? '';
    else {
      var commit = new GitCommit(config['commit_sha'] ?? '', config['git_message'] ?? '');
      commit.authorEmail = config['git_author_email'] ?? '';
      commit.authorName = config['git_author_name'] ?? '';
      commit.committerEmail = config['git_committer_email'] ?? '';
      commit.committerName = config['git_committer_email'] ?? '';

      job.git = new GitData(commit, config['service_branch'] ?? '');
    }
  }
}
