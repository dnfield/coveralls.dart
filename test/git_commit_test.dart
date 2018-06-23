import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [GitCommit] class.
void main() => group('GitCommit', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var commit = GitCommit.fromJson({});
      expect(commit.authorEmail, isEmpty);
      expect(commit.authorName, isEmpty);
      expect(commit.id, isEmpty);
      expect(commit.message, isEmpty);
    });

    test('should return an initialized instance for a non-empty map', () {
      var commit = GitCommit.fromJson({
        'author_email': 'anonymous@secret.com',
        'author_name': 'Anonymous',
        'id': '2ef7bde608ce5404e97d5f042f95f89f1c232871',
        'message': 'Hello World!'
      });

      expect(commit.authorEmail, equals('anonymous@secret.com'));
      expect(commit.authorName, equals('Anonymous'));
      expect(commit.id, equals('2ef7bde608ce5404e97d5f042f95f89f1c232871'));
      expect(commit.message, equals('Hello World!'));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = const GitCommit('').toJson();
      expect(map, hasLength(1));
      expect(map['id'], isEmpty);
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = const GitCommit(
        '2ef7bde608ce5404e97d5f042f95f89f1c232871',
        authorEmail: 'anonymous@secret.com',
        authorName: 'Anonymous',
        message: 'Hello World!'
      ).toJson();

      expect(map, hasLength(4));
      expect(map['author_email'], equals('anonymous@secret.com'));
      expect(map['author_name'], equals('Anonymous'));
      expect(map['id'], equals('2ef7bde608ce5404e97d5f042f95f89f1c232871'));
      expect(map['message'], equals('Hello World!'));
    });
  });

  group('.toString()', () {
    var data = const GitCommit(
      '2ef7bde608ce5404e97d5f042f95f89f1c232871',
      authorEmail: 'anonymous@secret.com',
      authorName: 'Anonymous',
      message: 'Hello World!'
    ).toString();

    test('should start with the class name', () {
      expect(data.indexOf('GitCommit {'), equals(0));
    });

    test('should contain the instance properties', () {
      expect(data, contains('"author_email":"anonymous@secret.com"'));
      expect(data, contains('"author_name":"Anonymous"'));
      expect(data, contains('"id":"2ef7bde608ce5404e97d5f042f95f89f1c232871"'));
      expect(data, contains('"message":"Hello World!"'));
    });
  });
});
