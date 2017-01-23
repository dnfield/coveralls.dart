/// Provides a connector for the [Jenkins](https://jenkins.io) service.
library coveralls.services.jenkins;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration => new Configuration({
  'commit_sha': Platform.environment['GIT_COMMIT'],
  'service_branch': Platform.environment['GIT_BRANCH'],
  'service_build_url': Platform.environment['BUILD_URL'],
  'service_job_id': Platform.environment['BUILD_ID'],
  'service_name': 'jenkins',
  'service_number': Platform.environment['BUILD_NUMBER'],
  'service_pull_request': Platform.environment['ghprbPullId']
});
