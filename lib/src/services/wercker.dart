/// Provides a connector for the [Wercker](http://www.wercker.com) service.
library coveralls.services.wercker;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration => new Configuration({
  'commit_sha': Platform.environment['WERCKER_GIT_COMMIT'],
  'service_branch': Platform.environment['WERCKER_GIT_BRANCH'],
  'service_job_id': Platform.environment['WERCKER_BUILD_ID'],
  'service_name': 'wercker'
});
