#!/usr/bin/env dart

import 'dart:async';
import 'dart:io';
import 'package:args/args.dart';
import 'package:coveralls/coveralls.dart';

/// The command line argument parser.
final ArgParser _parser = new ArgParser()
  ..addFlag('help', abbr: 'h', help: 'output usage information', negatable: false)
  ..addFlag('version', abbr: 'v', help: 'output the version number', negatable: false);

/// Application entry point.
Future main(List<String> arguments) async {
  try {
    var results = _parser.parse(arguments);
    if (results['help']) return printUsage();
    if (results['version']) return print(version);

    if (results.rest.isEmpty) {
      printUsage();
      exit(64);
    }

    var client = new Client(Platform.environment['COVERALLS_ENDPOINT'] ?? Client.defaultEndPoint);
    var coverage = await new File(results.rest.first).readAsString();
    print('[Coveralls] Submitting to ${client.endPoint}');
    return client.upload(coverage);
  }

  on Exception catch (err) {
    print(err);
    exit(1);
  }
}

/// Prints the usage information.
void printUsage() => print(new StringBuffer()
  ..writeln('Send a LCOV coverage report to the Coveralls service.')
  ..writeln()
  ..writeln('Usage:')
  ..writeln('pub global run coveralls [options] <file>')
  ..writeln()
  ..writeln('Options:')
  ..write(_parser.usage));
