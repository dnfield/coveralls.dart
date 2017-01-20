part of lcov;

/// Provides the list of supported CI services.
abstract class Service {

  /// AppVeyor.
  static const String appVeyor = 'appveyor';

  /// CircleCI.
  static const String circleCI = 'circleci';

  /// Codeship.
  static const String codeship = 'codeship';

  /// GitLab.
  static const String gitlabCI = 'gitlab-ci';

  /// Jenkins.
  static const String jenkinsCI = 'jenkins';

  /// Run locally.
  static const String local = 'coveralls-dart';

  /// Semaphore.
  static const String semaphore = 'semaphore';

  /// Solano CI.
  static const String solanoCI = 'tddium';

  /// Travis CI.
  static const String travisCI = 'travis-ci';

  /// Travis CI for private projects.
  static const String travisPro = 'travis-pro';

  /// Wercker.
  static const String wercker = 'wercker';

  /// TODO
  static Map<String, dynamic> getTravisCiConfig([String serviceName = travisCI]) {
    var map = {};

    return map;
  }
}
