part of coveralls;

/// Provides access to the coverage settings.
class Configuration extends MapBase<String, String> {

  /// The coverage parameters.
  final Map<String, dynamic> _params;

  /// Creates a new configuration from the specified [map].
  Configuration([Map<String, dynamic> map]): _params = map ?? {};

  /// Creates a new configuration from the variables of the specified environment.
  /// If [env] is not provided, it defaults to [Platform.environment].
  Configuration.fromEnvironment([Map<String, String> env]): _params = {} {
    if (env == null) env = Platform.environment;

    // Standard.
    var serviceName = env['CI_NAME'] ?? '';
    if (serviceName.isNotEmpty) this['service_name'] = serviceName;

    if (env.containsKey('CI_BRANCH')) this['service_branch'] = env['CI_BRANCH'];
    if (env.containsKey('CI_BUILD_NUMBER')) this['service_number'] = env['CI_BUILD_NUMBER'];
    if (env.containsKey('CI_BUILD_URL')) this['service_build_url'] = env['CI_BUILD_URL'];
    if (env.containsKey('CI_COMMIT')) this['commit_sha'] = env['CI_COMMIT'];
    if (env.containsKey('CI_JOB_ID')) this['service_job_id'] = env['CI_JOB_ID'];

    if (env.containsKey('CI_PULL_REQUEST')) {
      var matches = new RegExp(r'(\d+)$').allMatches(env['CI_PULL_REQUEST']);
      if (matches.isNotEmpty && matches.first.groupCount >= 1) this['service_pull_request'] = matches.first[1];
    }

    // Coveralls.
    if (env.containsKey('COVERALLS_REPO_TOKEN') || env.containsKey('COVERALLS_TOKEN'))
      this['repo_token'] = env['COVERALLS_REPO_TOKEN'] ?? env['COVERALLS_TOKEN'];

    if (env.containsKey('COVERALLS_COMMIT_SHA')) this['commit_sha'] = env['COVERALLS_COMMIT_SHA'];
    if (env.containsKey('COVERALLS_PARALLEL')) this['parallel'] = env['COVERALLS_PARALLEL'];
    if (env.containsKey('COVERALLS_RUN_AT')) this['run_at'] = env['COVERALLS_RUN_AT'];
    if (env.containsKey('COVERALLS_SERVICE_BRANCH')) this['service_branch'] = env['COVERALLS_SERVICE_BRANCH'];
    if (env.containsKey('COVERALLS_SERVICE_JOB_ID')) this['service_job_id'] = env['COVERALLS_SERVICE_JOB_ID'];
    if (env.containsKey('COVERALLS_SERVICE_NAME')) this['service_name'] = env['COVERALLS_SERVICE_NAME'];

    // CI services.
    if (env.containsKey('TRAVIS')) addAll(travis_ci.configuration);
    else if (env.containsKey('APPVEYOR')) addAll(appveyor.configuration);
    else if (env.containsKey('CIRCLECI')) addAll(circleci.configuration);
    else if (serviceName == 'codeship') addAll(codeship.configuration);
    else if (env.containsKey('GITLAB_CI')) addAll(gitlab_ci.configuration);
    else if (env.containsKey('JENKINS_URL')) addAll(jenkins.configuration);
    else if (env.containsKey('SEMAPHORE')) addAll(semaphore.configuration);
    else if (env.containsKey('SURF_SHA1')) addAll(surf.configuration);
    else if (env.containsKey('TDDIUM')) addAll(solano_ci.configuration);
    else if (env.containsKey('WERCKER')) addAll(wercker.configuration);
  }

  /// Creates a new configuration from the specified YAML [document].
  Configuration.fromYaml(String document): this(loadYaml(document));
  // TODO check if YAML is a Map<String, String>, otherwise throw new FormatException();

  /// The keys of this configuration.
  @override
  Iterable<String> get keys => _params.keys;

  /// Returns the value for the given [key] or `null` if [key] is not in this configuration.
  @override
  String operator [](Object key) => _params[key];

  /// Associates the [key] with the given [value].
  @override
  void operator []=(String key, dynamic value) => _params[key] = value;

  /// Removes all pairs from this configuration.
  @override
  void clear() => _params.clear();

  /// Loads the default configuration.
  /// The default values are read from the `.coveralls.yml` file and the environment variables.
  static Future<Configuration> loadDefaults() async {
    var defaults = new Configuration();

    var file = new File('${Directory.current.path}/.coveralls.yml');
    if (await file.exists()) defaults.addAll(new Configuration.fromYaml(await file.readAsString()));

    defaults.addAll(new Configuration.fromEnvironment());
    return defaults;
  }

  /// Removes the specified [key] and its associated value from this configuration.
  /// Returns the value associated with [key] before it was removed.
  @override
  String remove(Object key) => _params.remove(key);

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => _params;

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
