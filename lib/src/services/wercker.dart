/// Provides a connector for the [Wercker](http://www.wercker.com) service.
library coveralls.services.wercker;
import 'dart:io';

/// The configuration parameters from the environment.
Map<String, String> get configuration => {
  'git_branch': Platform.environment['WERCKER_GIT_BRANCH'],
  'git_commit': Platform.environment['WERCKER_GIT_COMMIT'],
  'service_job_id': Platform.environment['WERCKER_BUILD_ID'],
  'service_name': 'wercker'
};
