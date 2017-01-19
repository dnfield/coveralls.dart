/// Send [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage reports to the [Coveralls](https://coveralls.io) service.
library coveralls;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lcov/lcov.dart';

part 'src/client.dart';
part 'src/formatter.dart';
part 'src/job.dart';
part 'src/source_file.dart';
