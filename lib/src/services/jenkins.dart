/// Provides a connector for the [Jenkins](https://jenkins.io) service.
library coveralls.services.jenkins;
import 'dart:io';

/// The configuration parameters from the environment.
Map<String, String> get configuration => {
  'git_branch': Platform.environment['GIT_BRANCH'],
  'git_commit': Platform.environment['GIT_COMMIT'],
  'service_job_id': Platform.environment['BUILD_ID'],
  'service_name': 'jenkins',
  'service_pull_request': Platform.environment['ghprbPullId']
};
