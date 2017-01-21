/// Provides a connector for the [Travis CI](https://travis-ci.com) service.
library coveralls.services.travis_ci;
import 'dart:io';

/// The configuration parameters from the environment.
Map<String, String> get configuration => {
  'git_branch': Platform.environment['TRAVIS_BRANCH'],
  'git_commit': 'HEAD',
  'service_job_id': Platform.environment['TRAVIS_JOB_ID'],
  'service_name': 'travis-ci'
};
