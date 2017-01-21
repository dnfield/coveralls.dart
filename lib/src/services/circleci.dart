/// Provides a connector for the [CircleCI](https://circleci.com) service.
library coveralls.services.circleci;
import 'dart:io';

/// The configuration parameters from the environment.
Map<String, String> get configuration {
  var map = {
    'git_branch': Platform.environment['CIRCLE_BRANCH'],
    'git_commit': Platform.environment['CIRCLE_SHA1'],
    'service_job_id': Platform.environment['CIRCLE_BUILD_NUM'],
    'service_name': 'circleci'
  };

  if (Platform.environment.containsKey('CI_PULL_REQUEST')) {
    var pullRequest = Platform.environment['CI_PULL_REQUEST'].split('/pull/');
    if (pullRequest.length >= 2) map['service_pull_request'] = pullRequest[1];
  }

  return map;
}
