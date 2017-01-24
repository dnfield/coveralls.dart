part of coveralls;

/// Provides access to the coverage settings.
class Configuration {

  /// The coverage parameters.
  final Map<String, dynamic> _params;

  /// Creates a new configuration from the specified [map].
  Configuration([Map<String, dynamic> map]): _params = map ?? {};

  /// Creates a new configuration from the environment variables.
  Configuration.fromEnvironment(): _params = {} {
    // Standard.
    if (Platform.environment.containsKey('CI_BRANCH')) this['service_branch'] = Platform.environment['CI_BRANCH'];
    if (Platform.environment.containsKey('CI_BUILD_NUMBER')) this['service_number'] = Platform.environment['CI_BUILD_NUMBER'];
    if (Platform.environment.containsKey('CI_BUILD_URL')) this['service_build_url'] = Platform.environment['CI_BUILD_URL'];
    if (Platform.environment.containsKey('CI_COMMIT')) this['commit_sha'] = Platform.environment['CI_COMMIT'];
    if (Platform.environment.containsKey('CI_JOB_ID')) this['service_job_id'] = Platform.environment['CI_JOB_ID'];
    if (Platform.environment.containsKey('CI_NAME')) this['service_name'] = Platform.environment['CI_NAME'];

    /* TODO
    var matches = new RegExp(r'(\d+)$').allMatches(Platform.environment['CI_PULL_REQUEST'] ?? '').toList();
    if (matches.length >= 2) this['service_pull_request'] = matches[1].toString();
    */

    // Coveralls.
    if (Platform.environment.containsKey('COVERALLS_COMMIT_SHA')) this['commit_sha'] = Platform.environment['COVERALLS_COMMIT_SHA'];
    if (Platform.environment.containsKey('COVERALLS_PARALLEL')) this['parallel'] = Platform.environment['COVERALLS_PARALLEL'];
    if (Platform.environment.containsKey('COVERALLS_REPO_TOKEN')) this['repo_token'] = Platform.environment['COVERALLS_REPO_TOKEN'];
    if (Platform.environment.containsKey('COVERALLS_RUN_AT')) this['run_at'] = Platform.environment['COVERALLS_RUN_AT'];
    if (Platform.environment.containsKey('COVERALLS_SERVICE_BRANCH')) this['service_branch'] = Platform.environment['COVERALLS_SERVICE_BRANCH'];
    if (Platform.environment.containsKey('COVERALLS_SERVICE_JOB_ID')) this['service_job_id'] = Platform.environment['COVERALLS_SERVICE_JOB_ID'];
    if (Platform.environment.containsKey('COVERALLS_SERVICE_NAME')) this['service_name'] = Platform.environment['COVERALLS_SERVICE_NAME'];

    // CI services.
    if (Platform.environment.containsKey('TRAVIS')) this.addAll(travis_ci.configuration);
    else if (Platform.environment.containsKey('APPVEYOR')) this.addAll(appveyor.configuration);
    else if (Platform.environment.containsKey('CIRCLECI')) this.addAll(circleci.configuration);
    else if (Platform.environment['CI_NAME'] == 'codeship') this.addAll(codeship.configuration);
    else if (Platform.environment.containsKey('GITLAB_CI')) this.addAll(gitlab_ci.configuration);
    else if (Platform.environment.containsKey('JENKINS_URL')) this.addAll(jenkins.configuration);
    else if (Platform.environment.containsKey('SEMAPHORE')) this.addAll(semaphore.configuration);
    else if (Platform.environment.containsKey('SURF_SHA1')) this.addAll(surf.configuration);
    else if (Platform.environment.containsKey('TDDIUM')) this.addAll(solano_ci.configuration);
    else if (Platform.environment.containsKey('WERCKER')) this.addAll(wercker.configuration);
  }

  /// Creates a new configuration from the specified YAML [document].
  Configuration.fromYaml(String document): this(loadYaml(document));

  /// TODO
  /*
  static Future<Configuration> getDefault() async {
    if (_default == null) {
      _default = new Configuration();

      var file = new File('${Directory.current.path}/.coveralls.yml');
      if (await file.exists()) _default.merge(new Configuration.fromYaml(await file.readAsString()));

      _default.merge(new Configuration.fromEnvironment());
    }

    return _default;
  }*/

  /// Returns the value for the given [key] or `null` if [key] is not in the map.
  String operator [](Object key) => _params[key];

  /// Associates the [key] with the given [value].
  void operator []=(String key, dynamic value) {
    _params[key] = value;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
