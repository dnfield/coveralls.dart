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



Future<Map> getConfigFromFile(String path) {

}

Future<Map> getConfigFromEnvironment() {
  
}

/// TODO
Future<Job> getJob() async {
  var job = new Job();

  // Fetch values from the configuration file.
  var file = new File('${Directory.current}/.coveralls.yml');
  if (await file.exists()) {

  }

  // Fetch values from the environment variables.
  var path = await new File('${Directory.current}/.coveralls.yml').exists();
}

Map<String, dynamic> _parseYamlConfig() {

}
