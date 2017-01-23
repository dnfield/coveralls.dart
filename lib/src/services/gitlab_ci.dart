/// Provides a connector for the [GitLab CI](https://gitlab.com) service.
library coveralls.services.gitlab_ci;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration => new Configuration({
  'commit_sha': Platform.environment['CI_BUILD_REF'],
  'service_branch': Platform.environment['CI_BUILD_REF_NAME'],
  'service_job_id': Platform.environment['CI_BUILD_ID'],
  'service_job_number': Platform.environment['CI_BUILD_NAME'],
  'service_name': 'gitlab-ci'
});
