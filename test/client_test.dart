import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  group('.upload()', () {
    test('should throw an exception with an empty coverage report', () {
      expect(new Client().upload(''), throwsFormatException);
    });
  });

  group('.uploadJob()', () {
    test('should throw an exception with an empty coverage job', () {
      expect(new Client().uploadJob(new Job()), throwsArgumentError);
    });
  });
});
