/// Provides a connector for the [AppVeyor](https://www.appveyor.com) service.
library coveralls.services.appveyor;
import 'dart:io';

/// The configuration parameters from the environment.
Map<String, String> get configuration => {
  'git_branch': Platform.environment['APPVEYOR_REPO_BRANCH'],
  'git_commit': Platform.environment['APPVEYOR_REPO_COMMIT'],
  'service_job_id': Platform.environment['APPVEYOR_BUILD_ID'],
  'service_job_number': Platform.environment['APPVEYOR_BUILD_NUMBER'],
  'service_name': 'appveyor'
};
