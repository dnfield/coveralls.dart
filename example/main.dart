import 'dart:async';
import 'dart:io';
import 'package:coveralls/coveralls.dart';

/// Uploads a coverage report.
Future<void> main() async {
  try {
    var coverage = File('/path/to/coverage.report');
    await Client().upload(await coverage.readAsString());
    print('The report was sent successfully.');
  }

  on Exception catch (err) {
    print('An error occurred: $err');
  }
}
