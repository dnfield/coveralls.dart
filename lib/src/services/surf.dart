/// Provides a connector for the [Surf](https://github.com/surf-build/surf) service.
library coveralls.services.surf;

import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// The configuration parameters from the environment.
Configuration get configuration => new Configuration({
  'commit_sha': Platform.environment['SURF_SHA1'],
  'service_branch': Platform.environment['SURF_REF'],
  'service_name': 'surf'
});
