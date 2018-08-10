part of '../io.dart';

/// Converts the specified [GitData] instance to a JSON object.
Map<String, dynamic> _gitDataToJson(GitData data) => data.toJson();

/// Converts the specified list of [SourceFile] instances to a list of JSON objects.
List<Map<String, dynamic>> _sourceFilesToJson(List<SourceFile> files) => files.map((file) => file.toJson()).toList();

/// Represents the coverage data from a single run of a test suite.
@JsonSerializable(includeIfNull: false)
class Job {

  /// Creates a new job.
  Job({this.repoToken, this.serviceJobId, this.serviceName, Iterable<SourceFile> sourceFiles}): sourceFiles = sourceFiles?.toList() ?? <SourceFile>[];

  /// Creates a new job from the specified [map] in JSON format.
  factory Job.fromJson(Map<String, dynamic> map) => _$JobFromJson(map);

  /// The current SHA of the commit being built to override the [git] property.
  @JsonKey(name: 'commit_sha')
  String commitSha;

  /// A map of Git data that can be used to display more information to users.
  @JsonKey(toJson: _gitDataToJson)
  GitData git;

  /// Value indicating whether the build will not be considered done until a webhook has been sent to Coveralls.
  @JsonKey(name: 'parallel')
  bool isParallel;

  /// The secret token for the repository.
  @JsonKey(name: 'repo_token')
  String repoToken;

  /// A timestamp of when the job ran.
  @JsonKey(name: 'run_at')
  DateTime runAt;

  /// A unique identifier of the job on the CI service.
  @JsonKey(name: 'service_job_id')
  String serviceJobId;

  /// The CI service or other environment in which the test suite was run.
  @JsonKey(name: 'service_name')
  String serviceName;

  /// The build number.
  @JsonKey(name: 'service_number')
  String serviceNumber;

  /// The associated pull request ID of the build.
  @JsonKey(name: 'service_pull_request')
  String servicePullRequest;

  /// The list of source files.
  @JsonKey(name: 'source_files', toJson: _sourceFilesToJson)
  final List<SourceFile> sourceFiles;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson()  => _$JobToJson(this);

  /// Returns a [String] representation of this object.
  @override
  String toString() => 'Job ${json.encode(this)}';
}
