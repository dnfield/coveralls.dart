/// Send [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage reports to the [Coveralls](https://coveralls.io) service.
library coveralls;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:lcov/lcov.dart';
import 'package:path/path.dart' as path;
import 'package:which/which.dart';
import 'package:yaml/yaml.dart';

import 'src/services/appveyor.dart' as appveyor;
import 'src/services/circleci.dart' as circleci;
import 'src/services/codeship.dart' as codeship;
import 'src/services/gitlab_ci.dart' as gitlab_ci;
import 'src/services/jenkins.dart' as jenkins;
import 'src/services/semaphore.dart' as semaphore;
import 'src/services/solano_ci.dart' as solano_ci;
import 'src/services/surf.dart' as surf;
import 'src/services/travis_ci.dart' as travis_ci;
import 'src/services/wercker.dart' as wercker;

part 'src/client.dart';
part 'src/configuration.dart';
part 'src/git_commit.dart';
part 'src/git_data.dart';
part 'src/git_remote.dart';
part 'src/job.dart';
part 'src/source_file.dart';

/// The version number of this package.
const String version = '0.3.0';
