/// Provides a connector for the [CircleCI](https://circleci.com) service.
library coveralls.services.circleci;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration {
  var config = new Configuration({
    'commit_sha': Platform.environment['CIRCLE_SHA1'],
    'parallel': int.parse(Platform.environment['CIRCLE_NODE_TOTAL'], radix: 10) > 1 ? 'true' : 'false',
    'service_branch': Platform.environment['CIRCLE_BRANCH'],
    'service_job_number': Platform.environment['CIRCLE_NODE_INDEX'],
    'service_name': 'circleci',
    'service_number': Platform.environment['CIRCLE_BUILD_NUM']
  });

  if (Platform.environment.containsKey('CI_PULL_REQUEST')) {
    var pullRequest = Platform.environment['CI_PULL_REQUEST'].split('/pull/');
    if (pullRequest.length >= 2) config['service_pull_request'] = pullRequest[1];
  }

  return config;
}
