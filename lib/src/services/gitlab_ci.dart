/// Provides a connector for the [GitLab CI](https://gitlab.com) service.
library coveralls.services.gitlab_ci;
import 'package:coveralls/coveralls.dart';

/// Gets the configuration parameters from the specified environment.
Configuration getConfiguration(Map<String, String> env) => new Configuration({
  'commit_sha': env['CI_BUILD_REF'],
  'service_branch': env['CI_BUILD_REF_NAME'],
  'service_job_id': env['CI_BUILD_ID'],
  'service_job_number': env['CI_BUILD_NAME'],
  'service_name': 'gitlab-ci'
});
