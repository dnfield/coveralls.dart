import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [Configuration] class.
void main() => group('Configuration', () {
  group('.fromEnvironment()', () {
    test('should be empty when there is no CI environment variables', () {
      var config = new Configuration.fromEnvironment();
      // TODO
    });

  });

  group('.fromYaml()', () {
    var config = new Configuration.fromEnvironment();
  });
});
