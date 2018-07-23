part of coveralls.cli;

/// The parsed command line arguments.
@CliOptions()
class Options {

  /// Value indicating whether to output usage information.
  @CliOption(abbr: 'h', help: 'Output usage information.', negatable: false)
  final bool help;

  /// The remaining command-line arguments that were not parsed as options or flags.
  final List<String> rest;

  /// Value indicating whether to output the version number.
  @CliOption(abbr: 'v', help: 'Output the version number.', negatable: false)
  final bool version;

  /// Creates a new options object.
  Options({this.help, this.rest, this.version});
}
