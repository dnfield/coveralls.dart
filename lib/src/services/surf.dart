/// Provides a connector for the [Surf](https://github.com/surf-build/surf) service.
library coveralls.services.surf;
import 'dart:io';

/// The configuration parameters from the environment.
Map<String, String> get configuration => {
  'git_branch': Platform.environment['SURF_REF'],
  'git_commit': Platform.environment['SURF_SHA1'],
  'service_name': 'surf'
};
