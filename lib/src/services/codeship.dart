/// Provides a connector for the [Codeship](https://codeship.com) service.
library coveralls.services.codeship;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration => new Configuration({
  'commit_sha': Platform.environment['CI_COMMIT_ID'],
  'git_committer_email': Platform.environment['CI_COMMITTER_EMAIL'],
  'git_committer_name': Platform.environment['CI_COMMITTER_NAME'],
  'git_message': Platform.environment['CI_COMMIT_MESSAGE'],
  'service_branch': Platform.environment['CI_BRANCH'],
  'service_job_id': Platform.environment['CI_BUILD_NUMBER'],
  'service_name': 'codeship'
});
