part of coveralls;

/// Uploads code coverage reports to the [Coveralls](https://coveralls.io) service.
class Client {

  /// The URL of the API end point.
  static final Uri defaultEndPoint = Uri.parse('https://coveralls.io/api/v1/jobs');

  /// Creates a new client.
  Client([endPoint]) {
    if (endPoint != null) this.endPoint = endPoint is Uri ? endPoint : Uri.parse(endPoint.toString());
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
  Future upload(String coverage, [Configuration configuration]) async {
    assert(coverage != null);

    var job = null;
    return uploadJob(job);
  }

  /// Uploads the specified [job] to the Coveralls service.
  /// Throws an [ArgumentError] if the job does not meet the requirements.
  Future uploadJob(Job job) async {
    assert(job != null);
    if (job.repoToken.isEmpty && job.serviceName.isEmpty) throw new ArgumentError.value(job, 'job', 'The job does not meet the requirements.');

    var request = new MultipartRequest('POST', endPoint);
    request.files.add(new MultipartFile.fromString('json_file', JSON.encode(job)));
    _onRequest.add(request);

    var streamedResponse = await request.send();
    var response = await Response.fromStream(streamedResponse);
    _onResponse.add(response);

    if (response.statusCode != 200) throw new HttpException(response.reasonPhrase, uri: request.url);
    return response;
  }

  /// Parses the specified [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage [report].
  Future<Job> _parseReport(String report) async {
    var sourceFiles = <SourceFile>[];
    for (var record in Report.parse(report).records) {
      var source;
      try { source = await new File(record.sourceFile).readAsString(); }
      catch (e) { throw new FileSystemException('Source file not found: ${record.sourceFile}'); }

      var lines = source.split(new RegExp('\r?\n'));
      var coverage = new List<int>(lines.length);
      for (var lineData in record.lines.data) coverage[lineData.lineNumber - 1] = lineData.executionCount;

      var filename = path.relative(record.sourceFile);
      var digest = await md5.convert(source.codeUnits).toString();
      sourceFiles.add(new SourceFile(filename, digest, source, coverage));
    }

    return new Job(sourceFiles);
  }

  /// Updates the properties of the specified [job] using the given configuration parameters.
  void _updateJob(Job job, Configuration config) {
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

    job.isParallel = config['parallel'] == 'true';
    job.repoToken = config['repo_token'] ?? (config['repo_secret_token'] ?? '');
    job.runAt = config['run_at'] != null ? DateTime.parse(config['run_at']) : null;
    job.serviceJobId = config['service_job_id'] ?? '';
    job.serviceName = config['service_name'] ?? '';
    job.serviceNumber = config['service_number'] ?? '';
    job.servicePullRequest = config['service_pull_request'] ?? '';
  }
}
