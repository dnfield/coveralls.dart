import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [GitRemote] class.
void main() => group('GitRemote', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var remote = new GitRemote.fromJson(const {});
      expect(remote.name, isEmpty);
      expect(remote.url, isNull);
    });

    test('should return an initialized instance for a non-empty map', () {
      var remote = new GitRemote.fromJson({
        'name': 'origin',
        'url': 'https://github.com/cedx/coveralls.dart.git'
      });

      expect(remote.name, equals('origin'));
      expect(remote.url, equals(Uri.parse('https://github.com/cedx/coveralls.dart.git')));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = new GitRemote().toJson();
      expect(map['name'], isEmpty);
      expect(map['url'], isNull);
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = new GitRemote('origin', 'https://github.com/cedx/coveralls.dart.git').toJson();
      expect(map['name'], equals('origin'));
      expect(map['url'], equals('https://github.com/cedx/coveralls.dart.git'));
    });
  });
});
