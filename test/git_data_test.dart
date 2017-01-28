import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [GitData] class.
void main() => group('GitData', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var data = new GitData.fromJson(const {});
      expect(data.branch, isEmpty);
      expect(data.commit, isNull);
      expect(data.remotes, allOf(isList, isEmpty));
    });

    test('should return an initialized instance for a non-empty map', () {
      var data = new GitData.fromJson({
        'branch': 'develop',
        'head': {'id': '2ef7bde608ce5404e97d5f042f95f89f1c232871'},
        'remotes': [{'name': 'origin'}]
      });

      expect(data.branch, equals('develop'));

      expect(data.commit, new isInstanceOf<GitCommit>());
      expect(data.commit.id, equals('2ef7bde608ce5404e97d5f042f95f89f1c232871'));

      expect(data.remotes, allOf(isList, hasLength(1)));
      expect(data.remotes[0], new isInstanceOf<GitRemote>());
      expect(data.remotes[0].name, equals('origin'));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = new GitData().toJson();
      expect(map['branch'], isEmpty);
      expect(map['head'], isNull);
      expect(map['remotes'], allOf(isList, isEmpty));
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = new GitData(new GitCommit('2ef7bde608ce5404e97d5f042f95f89f1c232871'), 'develop', [new GitRemote('origin')]).toJson();
      expect(map['branch'], equals('develop'));

      expect(map['head'], isMap);
      expect(map['head']['id'], equals('2ef7bde608ce5404e97d5f042f95f89f1c232871'));

      expect(map['remotes'], allOf(isList, hasLength(1)));
      expect(map['remotes'][0], isMap);
      expect(map['remotes'][0]['name'], equals('origin'));
    });
  });
});
