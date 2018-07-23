/// Provides the I/O support.
library coveralls.io;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:where/where.dart' show where;
import 'package:yaml/yaml.dart';

import 'io/parsers/clover.dart' deferred as clover;
import 'io/parsers/lcov.dart' deferred as lcov;
import 'io/services/appveyor.dart' as appveyor;
import 'io/services/circleci.dart' as circleci;
import 'io/services/codeship.dart' as codeship;
import 'io/services/gitlab_ci.dart' as gitlab_ci;
import 'io/services/jenkins.dart' as jenkins;
import 'io/services/semaphore.dart' as semaphore;
import 'io/services/solano_ci.dart' as solano_ci;
import 'io/services/surf.dart' as surf;
import 'io/services/travis_ci.dart' as travis_ci;
import 'io/services/wercker.dart' as wercker;

part 'io/client.dart';
part 'io/configuration.dart';
part 'io/git.dart';
part 'io/job.dart';
part 'io/source_file.dart';
