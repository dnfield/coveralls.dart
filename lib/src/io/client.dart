part of '../io.dart';

/// Uploads code coverage reports to the [Coveralls](https://coveralls.io) service.
class Client {

  /// Creates a new client.
  Client([Uri endPoint]): endPoint = endPoint ?? defaultEndPoint;

  /// The URL of the default API end point.
  static final Uri defaultEndPoint = Uri.https('coveralls.io', '/');

  /// The handler of "request" events.
  final StreamController<http.MultipartRequest> _onRequest = StreamController<http.MultipartRequest>.broadcast();

  /// The handler of "response" events.
  final StreamController<http.Response> _onResponse = StreamController<http.Response>.broadcast();

  /// The URL of the API end point.
  final Uri endPoint;

  /// The stream of "request" events.
  Stream<http.MultipartRequest> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<http.Response> get onResponse => _onResponse.stream;

  /// Uploads the specified code [coverage] report to the Coveralls service.
  /// A [configuration] object provides the environment settings.
  ///
  /// Completes with a [FormatException] if the specified coverage report is empty, or if its format is not supported.
  Future<void> upload(String coverage, [Configuration configuration]) async {
    final report = coverage.trim();
    if (report.isEmpty) throw const FormatException('The specified coverage report is empty.');

    Job job;
    if (report.substring(0, 5) == '<?xml' || report.substring(0, 10) == '<coverage') {
      await clover.loadLibrary();
      job = await clover.parseReport(report);
    }
    else {
      final token = report.substring(0, 3);
      if (token == 'TN:' || token == 'SF:') {
        await lcov.loadLibrary();
        job = await lcov.parseReport(report);
      }
    }

    if (job == null) throw FormatException('The specified coverage format is not supported.', report);
    _updateJob(job, configuration ?? await Configuration.loadDefaults());
    job.runAt ??= DateTime.now();

    try {
      await where('git');
      final git = await GitData.fromRepository();
      final branch = job.git != null ? job.git.branch : '';
      if (git.branch == 'HEAD' && branch.isNotEmpty) git.branch = branch;
      job.git = git;
    }

    on FinderException { /* Noop */ }
    return uploadJob(job);
  }

  /// Uploads the specified [job] to the Coveralls service.
  ///
  /// Completes with an [ArgumentError] if the job does not meet the requirements.
  /// Completes with a [http.ClientException] if the remote service does not respond successfully.
  Future<void> uploadJob(Job job) async {
    if (job.repoToken == null && job.serviceName == null)
      throw ArgumentError.value(job, 'job', 'The job does not meet the requirements.');

    final httpClient = http.Client();
    final request = http.MultipartRequest('POST', endPoint.resolve('api/v1/jobs'))
      ..files.add(http.MultipartFile.fromString('json_file', json.encode(job), filename: 'coveralls.json'));

    _onRequest.add(request);
    final response = await http.Response.fromStream(await httpClient.send(request));
    _onResponse.add(response);
    httpClient.close();

    if ((response.statusCode ~/ 100) != 2)
      throw http.ClientException('An error occurred while uploading the report.', request.url);
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

    final hasGitData = config.keys.any((key) => key == 'service_branch' || key.substring(0, 4) == 'git_');
    if (!hasGitData) job.commitSha = config['commit_sha'] ?? '';
    else {
      final commit = GitCommit(
        config['commit_sha'] ?? '',
        authorEmail: config['git_author_email'] ?? '',
        authorName: config['git_author_name'] ?? '',
        committerEmail: config['git_committer_email'] ?? '',
        committerName: config['git_committer_email'] ?? '',
        message: config['git_message'] ?? ''
      );

      job.git = GitData(commit, branch: config['service_branch'] ?? '');
    }
  }
}
