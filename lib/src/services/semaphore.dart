/// Provides a connector for the [Semaphore](https://semaphoreci.com) service.
library coveralls.services.semaphore;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration => new Configuration({
  'commit_sha': Platform.environment['REVISION'],
  'service_branch': Platform.environment['BRANCH_NAME'],
  'service_name': 'semaphore',
  'service_number': Platform.environment['SEMAPHORE_BUILD_NUMBER'],
  'service_pull_request': Platform.environment['PULL_REQUEST_NUMBER']
});
