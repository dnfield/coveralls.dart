#!/usr/bin/env dart

import 'dart:io';
import 'package:coveralls/coveralls.dart';
import 'package:coveralls/src/cli.dart';
import 'package:coveralls/src/version.dart';

/// The usage information.
final String usage = (StringBuffer()
  ..writeln('Send a coverage report to the Coveralls service.')
  ..writeln()
  ..writeln('Usage: coveralls [options] <file>')
  ..writeln()
  ..writeln('Options:')
  ..write(argParser.usage))
  .toString();

/// Application entry point.
Future<void> main(List<String> args) async {
  // Parse the command line arguments.
  Options options;

  try {
    options = parseOptions(args);
    if (options.help) {
      print(usage);
      return;
    }

    if (options.version) {
      print(packageVersion);
      return;
    }

    if (options.rest.isEmpty) throw const FormatException('A coverage report must be provided.');
  }

  on FormatException {
    print(usage);
    exitCode = 64;
    return;
  }

  // Run the program.
  try {
    final endPoint = const String.fromEnvironment('coveralls_endpoint') ?? Platform.environment['COVERALLS_ENDPOINT'];
    final client = Client(endPoint != null ? Uri.parse(endPoint) : Client.defaultEndPoint);

    final coverage = await File(options.rest.first).readAsString();
    print('[Coveralls] Submitting to ${client.endPoint}');
    await client.upload(coverage);
  }

  on Exception catch (err) {
    print(err);
    exitCode = 1;
  }
}
