/// Provides a connector for the [Travis CI](https://travis-ci.com) service.
library coveralls.services.travis_ci;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration {
  var config = new Configuration({
    'commit_sha': 'HEAD',
    'service_branch': Platform.environment['TRAVIS_BRANCH'],
    'service_job_id': Platform.environment['TRAVIS_JOB_ID'],
    'service_name': 'travis-ci'
  });

  if (Platform.environment.containsKey('TRAVIS_PULL_REQUEST') && Platform.environment['TRAVIS_PULL_REQUEST'] != 'false')
    config['service_pull_request'] = Platform.environment['TRAVIS_PULL_REQUEST'];

  return config;
}
