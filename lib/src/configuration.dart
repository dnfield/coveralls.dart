part of coveralls;

/// Provides access to the coverage settings.
class Configuration extends Object with MapMixin<String, dynamic> {

  /// The coverage parameters.
  final Map<String, dynamic> _params;

  /// Creates a new configuration from the specified [map].
  Configuration([Map<String, dynamic> map]): _params = map ?? {};

  /// Creates a new configuration from the environment variables.
  Configuration.fromEnvironment(): _params = {} {
    this['run_at'] = Platform.environment['COVERALLS_RUN_AT'] ?? new DateTime.now().toIso8601String();
    if (Platform.environment.containsKey('COVERALLS_GIT_BRANCH')) this['git_branch'] = Platform.environment['COVERALLS_GIT_BRANCH'];
    if (Platform.environment.containsKey('COVERALLS_GIT_COMMIT')) this['git_commit'] = Platform.environment['COVERALLS_GIT_COMMIT'];
    if (Platform.environment.containsKey('COVERALLS_PARALLEL')) this['parallel'] = true;
    if (Platform.environment.containsKey('COVERALLS_REPO_TOKEN')) this['repo_token'] = Platform.environment['COVERALLS_REPO_TOKEN'];
    if (Platform.environment.containsKey('COVERALLS_SERVICE_JOB_ID')) this['service_job_id'] = Platform.environment['COVERALLS_SERVICE_JOB_ID'];
    if (Platform.environment.containsKey('COVERALLS_SERVICE_NAME')) this['service_name'] = Platform.environment['COVERALLS_SERVICE_NAME'];

    var matches = new RegExp(r'(\d+)$').allMatches(Platform.environment['CI_PULL_REQUEST'] ?? '').toList();
    if (matches.length >= 2) this['service_pull_request'] = matches[1].toString();

    if (Platform.environment.containsKey('TRAVIS')) this.addAll(travis_ci.configuration);
    else if (Platform.environment.containsKey('APPVEYOR')) this.addAll(appveyor.configuration);
    else if (Platform.environment.containsKey('CIRCLECI')) this.addAll(circleci.configuration);
    else if (Platform.environment['CI_NAME'] == 'codeship') this.addAll(codeship.configuration);
    else if (Platform.environment.containsKey('GITLAB_CI')) this.addAll(gitlab_ci.configuration);
    else if (Platform.environment.containsKey('JENKINS_URL')) this.addAll(jenkins.configuration);
    else if (Platform.environment.containsKey('SURF_SHA1')) this.addAll(surf.configuration);
    else if (Platform.environment.containsKey('WERCKER')) this.addAll(wercker.configuration);
  }

  /// Creates a new configuration from the specified YAML [document].
  Configuration.fromYaml(String document): this(loadYaml(document));

  /// The keys of this configuration.
  @override
  Iterable<String> get keys => _params.keys;

  /// The secret token for the repository.
  String get repoToken => this['repo_token'];
  set repoToken(String value) => this['repo_token'] = value;

  /// The CI service or other environment in which the test suite was run.
  String get serviceName => this['service_name'];
  set serviceName(String value) => this['service_name'] = value;

  /// Returns the value for the given [key] or `null` if [key] is not in the map.
  @override
  String operator [](Object key) => _params[key];

  /// Associates the [key] with the given [value].
  @override
  void operator []=(String key, dynamic value) {
    _params[key] = value;
  }

  /// Removes all pairs from the map.
  @override
  void clear() => _params.clear();

  /// Removes [key] and its associated value, if present, from the map.
  @override
  String remove(Object key) => this.remove(key);
}
