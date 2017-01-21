/// Provides a connector for the [GitLab CI](https://gitlab.com) service.
library coveralls.services.gitlab_ci;
import 'dart:io';

/// The configuration parameters from the environment.
Map<String, String> get configuration => {
  'git_branch': Platform.environment['CI_BUILD_REF_NAME'],
  'git_commit': Platform.environment['CI_BUILD_REF'],
  'service_job_id': Platform.environment['CI_BUILD_ID'],
  'service_job_number': Platform.environment['CI_BUILD_NAME'],
  'service_name': 'gitlab-ci'
};
