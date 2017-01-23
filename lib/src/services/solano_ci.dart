/// Provides a connector for the [Solano CI](https://ci.solanolabs.com) service.
library coveralls.services.solano_ci;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration {
  var serviceNumber = Platform.environment['TDDIUM_SESSION_ID'];
  return new Configuration({
    'service_branch': Platform.environment['TDDIUM_CURRENT_BRANCH'],
    'service_build_url': 'https://ci.solanolabs.com/reports/$serviceNumber',
    'service_job_number': Platform.environment['TDDIUM_TID'],
    'service_name': 'tddium',
    'service_number': serviceNumber,
    'service_pull_request': Platform.environment['TDDIUM_PR_ID']
  });
}
