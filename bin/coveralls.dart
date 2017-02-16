#!/usr/bin/env dart

import 'dart:async';
import 'dart:io';
import 'package:args/args.dart';
import 'package:coveralls/coveralls.dart';

/// The command line argument parser.
final ArgParser _parser = new ArgParser()
  ..addOption('file', abbr: 'f', help: 'path to the coverage report', valueHelp: 'file')
  ..addFlag('help', abbr: 'h', help: 'output usage information', negatable: false)
  ..addFlag('version', abbr: 'v', help: 'output the version number', negatable: false);

/// Application entry point.
Future main(List<String> arguments) async {
  try {
    var results = _parser.parse(arguments);
    if (results['help']) return printUsage();
    if (results['version']) return print(version);

    if (results['file'] == null) {
      printUsage();
      exit(1);
    }

    var file = new File(results['file']);
    if (!await file.exists()) throw new FileSystemException('The specified file is not found.', file.path);

    var client = new Client(Platform.environment['COVERALLS_ENDPOINT'] ?? Client.defaultEndPoint);
    var coverage = await file.readAsString();
    
    print('[Coveralls] Submitting to ${client.endPoint}');
    await client.upload(coverage);
  }

  catch(error) {
    print(error);
    exit(2);
  }
}

/// Prints the usage information.
void printUsage() => print(new StringBuffer()
  ..writeln('Send a LCOV coverage report to the Coveralls service.')
  ..writeln()
  ..writeln('Usage:')
  ..writeln('pub global run coveralls [options]')
  ..writeln()
  ..writeln('Options:')
  ..write(_parser.usage));
