#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:coveralls/coveralls.dart';

/// The command line argument parser.
final ArgParser _parser = new ArgParser()
  ..addFlag('help', abbr: 'h', help: 'output usage information', negatable: false)
  ..addFlag('version', abbr: 'v', help: 'output the version number', negatable: false);

/// Application entry point.
void main(List<String> arguments) {
  try {
    var results = _parser.parse(arguments);
    if (results['help']) return printUsage();
    if (results['version']) return print('v$version');
  }

  on FormatException catch(error) {
    print(error.message);
    exit(1);
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
