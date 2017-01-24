part of coveralls;

/// Provides access to the coverage settings.
class Configuration extends IterableBase<String> {

  /// The coverage parameters.
  final Map<String, dynamic> _params;

  /// Creates a new configuration from the specified [map].
  Configuration([Map<String, dynamic> map]): _params = map ?? {};

  /// Creates a new configuration from the environment variables.
  Configuration.fromEnvironment(): _params = {} {
    // Standard.
    var serviceName = Platform.environment['CI_NAME'] ?? '';
    if (serviceName.isNotEmpty) this['service_name'] = serviceName;

    if (Platform.environment.containsKey('CI_BRANCH')) this['service_branch'] = Platform.environment['CI_BRANCH'];
    if (Platform.environment.containsKey('CI_BUILD_NUMBER')) this['service_number'] = Platform.environment['CI_BUILD_NUMBER'];
    if (Platform.environment.containsKey('CI_BUILD_URL')) this['service_build_url'] = Platform.environment['CI_BUILD_URL'];
    if (Platform.environment.containsKey('CI_COMMIT')) this['commit_sha'] = Platform.environment['CI_COMMIT'];
    if (Platform.environment.containsKey('CI_JOB_ID')) this['service_job_id'] = Platform.environment['CI_JOB_ID'];

    if (Platform.environment.containsKey('CI_PULL_REQUEST')) {
      var matches = new RegExp(r'(\d+)$').allMatches(Platform.environment['CI_PULL_REQUEST']);
      if (matches.isNotEmpty && matches.first.groupCount >= 1) this['service_pull_request'] = matches.first[1];
    }

    // Coveralls.
    if (Platform.environment.containsKey('COVERALLS_COMMIT_SHA')) this['commit_sha'] = Platform.environment['COVERALLS_COMMIT_SHA'];
    if (Platform.environment.containsKey('COVERALLS_PARALLEL')) this['parallel'] = Platform.environment['COVERALLS_PARALLEL'];
    if (Platform.environment.containsKey('COVERALLS_REPO_TOKEN')) this['repo_token'] = Platform.environment['COVERALLS_REPO_TOKEN'];
    if (Platform.environment.containsKey('COVERALLS_RUN_AT')) this['run_at'] = Platform.environment['COVERALLS_RUN_AT'];
    if (Platform.environment.containsKey('COVERALLS_SERVICE_BRANCH')) this['service_branch'] = Platform.environment['COVERALLS_SERVICE_BRANCH'];
    if (Platform.environment.containsKey('COVERALLS_SERVICE_JOB_ID')) this['service_job_id'] = Platform.environment['COVERALLS_SERVICE_JOB_ID'];
    if (Platform.environment.containsKey('COVERALLS_SERVICE_NAME')) this['service_name'] = Platform.environment['COVERALLS_SERVICE_NAME'];

    // CI services.
    if (Platform.environment.containsKey('TRAVIS')) merge(travis_ci.configuration);
    else if (Platform.environment.containsKey('APPVEYOR')) merge(appveyor.configuration);
    else if (Platform.environment.containsKey('CIRCLECI')) merge(circleci.configuration);
    else if (serviceName == 'codeship') merge(codeship.configuration);
    else if (Platform.environment.containsKey('GITLAB_CI')) merge(gitlab_ci.configuration);
    else if (Platform.environment.containsKey('JENKINS_URL')) merge(jenkins.configuration);
    else if (Platform.environment.containsKey('SEMAPHORE')) merge(semaphore.configuration);
    else if (Platform.environment.containsKey('SURF_SHA1')) merge(surf.configuration);
    else if (Platform.environment.containsKey('TDDIUM')) merge(solano_ci.configuration);
    else if (Platform.environment.containsKey('WERCKER')) merge(wercker.configuration);
  }

  /// Creates a new configuration from the specified YAML [document].
  Configuration.fromYaml(String document): this(loadYaml(document));

  /// Returns a new iterator that allows iterating the keys of this configuration.
  @override
  Iterator<String> get iterator => _params.keys.iterator;

  /// Returns the value for the given [key] or `null` if [key] is not in the map.
  String operator [](String key) => _params[key];

  /// Associates the [key] with the given [value].
  void operator []=(String key, dynamic value) => _params[key] = value;

  /// Loads the default configuration.
  /// The default values are read from the `.coveralls.yml` file and the environment variables.
  static Future<Configuration> loadDefaults() async {
    var defaults = new Configuration();

    var file = new File('${Directory.current.path}/.coveralls.yml');
    if (await file.exists()) defaults.merge(new Configuration.fromYaml(await file.readAsString()));

    defaults.merge(new Configuration.fromEnvironment());
    return defaults;
  }

  /// Adds all key-value pairs of the specified configuration to this one.
  void merge(Configuration config) {
    for (var key in config) this[key] = config[key];
  }

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => _params;

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
