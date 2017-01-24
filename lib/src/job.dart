part of coveralls;

/// Represents the coverage data from a single run of a test suite.
class Job {

  /// Creates a new job from the specified list of source files.
  Job([List<SourceFile> sourceFiles]): sourceFiles = sourceFiles ?? [];

  /// Creates a new job from the specified [map] in JSON format.
  Job.fromJson(Map<String, dynamic> map):
    commitSha = map['commit_sha'] != null ? map['commit_sha'].toString() : null,
    git = map['git'] is Map<String, dynamic> ? map['git'] : null,
    parallel = map['parallel'] is bool ? map['parallel'] : null,
    repoToken = map['repo_token'] != null ? map['repo_token'].toString() : null,
    runAt = map['run_at'] != null ? DateTime.parse(map['run_at'].toString()) : null,
    serviceJobId = map['service_job_id'] != null ? map['service_job_id'].toString() : null,
    serviceName = map['service_name'] != null ? map['service_name'].toString() : null,
    serviceNumber = map['service_number'] != null ? map['service_number'].toString() : null,
    servicePullRequest = map['service_pull_request'] != null ? map['service_pull_request'].toString() : null,
    sourceFiles = map['source_files'] is List<Map> ? map['source_files'].map((item) => new SourceFile.fromJson(item)).toList() : [];

  /// The current SHA of the commit being built to override the [git] property.
  String commitSha;

  /// A map of Git data that can be used to display more information to users.
  Map<String, dynamic> git;

  /// Value indicating whether the build will not be considered done until a webhook has been sent to Coveralls.
  bool parallel;

  /// The secret token for the repository.
  String get repoToken => this.config['repo_token'];
  set repoToken(String value) => this.config['repo_token'] = value;

  /// A timestamp of when the job ran.
  DateTime runAt;

  /// A unique identifier of the job on the service specified by [serviceName].
  String serviceJobId;

  /// The CI service or other environment in which the test suite was run.
  String get serviceName => this.config['service_name'];
  set serviceName(String value) => this.config['service_name'] = value;

  /// The build number.
  String serviceNumber;

  /// The associated pull request ID of the build.
  String servicePullRequest;

  /// The list of source files.
  final List<SourceFile> sourceFiles;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    if (repoToken != null) map['repo_token'] = repoToken;
    if (serviceName != null) map['service_name'] = serviceName;
    if (serviceNumber != null) map['service_number'] = serviceNumber;
    if (serviceJobId != null) map['service_job_id'] = serviceJobId;
    if (servicePullRequest != null) map['service_pull_request'] = servicePullRequest;

    map['source_files'] = sourceFiles.map((item) => item.toJson()).toList();
    if (parallel != null) map['parallel'] = parallel;
    if (git != null) map['git'] = git;
    if (commitSha != null) map['commit_sha'] = commitSha;
    if (runAt != null) map['run_at'] = runAt.toIso8601String();

    return map;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
