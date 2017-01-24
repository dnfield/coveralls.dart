/// Provides a connector for the [AppVeyor](https://www.appveyor.com) service.
library coveralls.services.appveyor;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration {
  var repoName = Platform.environment['APPVEYOR_REPO_NAME'];
  var serviceNumber = Platform.environment['APPVEYOR_BUILD_VERSION'];

  return new Configuration({
    'commit_sha': Platform.environment['APPVEYOR_REPO_COMMIT'],
    'git_author_email': Platform.environment['APPVEYOR_REPO_COMMIT_AUTHOR_EMAIL'],
    'git_author_name': Platform.environment['APPVEYOR_REPO_COMMIT_AUTHOR'],
    'git_message': Platform.environment['APPVEYOR_REPO_COMMIT_MESSAGE'],
    'service_branch': Platform.environment['APPVEYOR_REPO_BRANCH'],
    'service_build_url': 'https://ci.appveyor.com/project/$repoName/build/$serviceNumber',
    'service_job_id': Platform.environment['APPVEYOR_BUILD_ID'],
    'service_job_number': Platform.environment['APPVEYOR_BUILD_NUMBER'],
    'service_name': 'appveyor',
    'service_number': serviceNumber
  });
}
