part of coveralls;

/// Formats [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage reports to the format used by the [Coveralls](https://coveralls.io) service.
class Formatter {

  /// The configuration parameters.
  final Configuration config = new Configuration.fromEnvironment();

  /// Formats as hitmap the specified code [coverage] report in LCOV format.
  Future<Map> format(String coverage) async {
    var report = Report.parse(coverage);
    return report.toJson();
  }

  /// Formats as hitmap the specified code [coverage] report in LCOV format.
  Future<Map> formatFile(File coverage) async {
    assert(coverage != null);
    if (!await coverage.exists())
      throw new ArgumentError.value(coverage, 'coverage', 'The specified file does not exist.');

    return format(await coverage.readAsString());
  }
}
