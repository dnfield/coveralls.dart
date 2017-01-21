/// Provides a connector for the [Codeship](https://codeship.com) service.
library coveralls.services.codeship;
import 'dart:io';

/// The configuration parameters from the environment.
Map<String, String> get configuration => {
  'git_branch': Platform.environment['CI_BRANCH'],
  'git_commit': Platform.environment['CI_COMMIT_ID'],
  'git_committer_email': Platform.environment['CI_COMMITTER_EMAIL'],
  'git_committer_name': Platform.environment['CI_COMMITTER_NAME'],
  'git_message': Platform.environment['CI_COMMIT_MESSAGE'],
  'service_job_id': Platform.environment['CI_BUILD_NUMBER'],
  'service_name': 'codeship'
};
