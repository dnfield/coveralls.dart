import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [GitData] class.
void main() => group('GitData', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var data = GitData.fromJson({});
      expect(data.branch, isEmpty);
      expect(data.commit, isNull);
      expect(data.remotes, isEmpty);
    });

    test('should return an initialized instance for a non-empty map', () {
      var data = GitData.fromJson({
        'branch': 'develop',
        'head': {'id': '2ef7bde608ce5404e97d5f042f95f89f1c232871'},
        'remotes': [{'name': 'origin'}]
      });

      expect(data.branch, equals('develop'));

      expect(data.commit, const TypeMatcher<GitCommit>());
      expect(data.commit.id, equals('2ef7bde608ce5404e97d5f042f95f89f1c232871'));

      expect(data.remotes, hasLength(1));
      expect(data.remotes.first, const TypeMatcher<GitRemote>());
      expect(data.remotes.first.name, equals('origin'));
    });
  });

  group('.fromRepository()', () {
    test('should retrieve the Git data from the executable output', () async {
      var data = await GitData.fromRepository();
      expect(data.branch, isNotEmpty);

      expect(data.commit, const TypeMatcher<GitCommit>());
      expect(data.commit.id, matches(RegExp(r'^[a-f\d]{40}$')));

      expect(data.remotes, isNotEmpty);
      expect(data.remotes.first, const TypeMatcher<GitRemote>());

      var origin = data.remotes.where((remote) => remote.name == 'origin').toList();
      expect(origin, hasLength(1));
      expect(origin.first.url, equals(Uri.https('github.com', '/cedx/coveralls.dart.git')));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = GitData(null).toJson();
      expect(map['branch'], isEmpty);
      expect(map['head'], isNull);
      expect(map['remotes'], allOf(isList, isEmpty));
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = GitData(
        const GitCommit('2ef7bde608ce5404e97d5f042f95f89f1c232871'),
        branch: 'develop',
        remotes: [GitRemote('origin')]
      ).toJson();

      expect(map['branch'], equals('develop'));
      expect(map['head'], isMap);
      expect(map['head']['id'], equals('2ef7bde608ce5404e97d5f042f95f89f1c232871'));
      expect(map['remotes'], allOf(isList, hasLength(1)));
      expect(map['remotes'].first, isMap);
      expect(map['remotes'].first['name'], equals('origin'));
    });
  });

  group('.toString()', () {
    var data = GitData(
      const GitCommit('2ef7bde608ce5404e97d5f042f95f89f1c232871'),
      branch: 'develop',
      remotes: [GitRemote('origin')]
    ).toString();

    test('should start with the class name', () {
      expect(data.indexOf('GitData {'), equals(0));
    });

    test('should contain the instance properties', () {
      expect(data, contains('"branch":"develop"'));
      expect(data, contains('"head":{'));
      expect(data, contains('"remotes":[{'));
    });
  });
});
