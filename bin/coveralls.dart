#!/usr/bin/env dart

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:args/args.dart';
import 'package:coveralls/coveralls.dart';
import 'package:yaml/yaml.dart';

/// The command line argument parser.
final ArgParser _parser = ArgParser()
  ..addFlag('help', abbr: 'h', help: 'Output usage information.', negatable: false)
  ..addFlag('version', abbr: 'v', help: 'Output the version number.', negatable: false);

/// The usage information.
final String usage = (StringBuffer()
  ..writeln('Send a coverage report to the Coveralls service.')
  ..writeln()
  ..writeln('Usage: coveralls [options] <file>')
  ..writeln()
  ..writeln('Options:')
  ..write(_parser.usage))
  .toString();

/// The version number of this package.
Future<String> get version async {
  var package = await Isolate.resolvePackageUri(Uri.parse('package:coveralls/'));
  var pubspec = loadYaml(await File(package.resolve('../pubspec.yaml').toFilePath()).readAsString());
  return pubspec['version'];
}

/// Application entry point.
Future<void> main(List<String> args) async {
  // Parse the command line arguments.
  ArgResults results;

  try {
    results = _parser.parse(args);
    if (results['help']) {
      print(usage);
      return;
    }

    if (results['version']) {
      print(await version);
      return;
    }

    if (results.rest.isEmpty) throw ArgParserException('A coverage report must be provided.');
  }

  on ArgParserException {
    print(usage);
    exitCode = 64;
    return;
  }

  // Run the program.
  try {
    var endPoint = const String.fromEnvironment('coveralls_endpoint') ?? Platform.environment['COVERALLS_ENDPOINT'];
    var client = Client(endPoint != null ? Uri.parse(endPoint) : Client.defaultEndPoint);

    var coverage = await File(results.rest.first).readAsString();
    print('[Coveralls] Submitting to ${client.endPoint}');
    await client.upload(coverage);
  }

  on Exception catch (err) {
    print(err);
    exitCode = 1;
  }
}
