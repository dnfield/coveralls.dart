import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [Configuration] class.
void main() => group('Configuration', () {
  group('.keys', () {
    test('should return an empty array for an empty configuration', () {
      expect(new Configuration().keys, isEmpty);
    });

    test('should return the list of keys for a non-empty configuration', () {
      var keys = new Configuration({'foo': 'bar', 'bar': 'baz'}).keys.toList();
      expect(keys, hasLength(2));
      expect(keys[0], equals('foo'));
      expect(keys[1], equals('bar'));
    });
  });

  group('operator []', () {
    test('should properly get and set the configuration entries', () {
      var config = new Configuration();
      expect(config['foo'], isNull);

      config['foo'] = 'bar';
      expect(config['foo'], equals('bar'));
    });
  });

  group('.clear()', () {
    test('should be empty when there is no CI environment variables', () {
      var config = new Configuration({'foo': 'bar', 'bar': 'baz'});
      expect(config, hasLength(2));
      config.clear();
      expect(config, hasLength(0));
    });
  });
  group('.fromEnvironment()', () {
    test('should return an empty configuration for an empty environment', () {
      expect(new Configuration.fromEnvironment({}), isEmpty);
    });

    test('should return an initialized instance for a non-empty environment', () {
      var config = new Configuration.fromEnvironment({
        'CI_NAME': 'travis-pro',
        'CI_PULL_REQUEST': 'PR #123',
        'COVERALLS_REPO_TOKEN': '0123456789abcdef',
        'GIT_MESSAGE': 'Hello World!',
        'TRAVIS': 'true',
        'TRAVIS_BRANCH': 'develop'
      });

      expect(config['commit_sha'], equals('HEAD'));
      expect(config['git_message'], equals('Hello World!'));
      expect(config['repo_token'], equals('0123456789abcdef'));
      expect(config['service_branch'], equals('develop'));
      expect(config['service_name'], equals('travis-pro'));
      expect(config['service_pull_request'], equals('123'));
    });
  });

  group('.fromYaml()', () {
    test('should throws an exception with a non-object value', () {
      expect(() => new Configuration.fromYaml('foo'), throwsFormatException);
    });

    test('should return an initialized instance for a non-empty map', () {
      var config = new Configuration.fromYaml('repo_token: 0123456789abcdef\nservice_name: travis-ci');
      expect(config, hasLength(2));
      expect(config['repo_token'], equals('0123456789abcdef'));
      expect(config['service_name'], equals('travis-ci'));
    });
  });

  group('.loadDefaults()', () {
    test('should properly initialize from a `.coveralls.yml` file', () async {
      var config = await Configuration.loadDefaults('test/.coveralls.yml');
      expect(config.length, greaterThanOrEqualTo(2));
      expect(config['repo_token'], equals('yYPv4mMlfjKgUK0rJPgN0AwNXhfzXpVwt'));
      expect(config['service_name'], equals('travis-pro'));
    });
  });

  group('.remove()', () {
    test('should be empty when there is no CI environment variables', () {
      var config = new Configuration({'foo': 'bar', 'bar': 'baz'});
      expect(config, contains('foo'));
      config.remove('foo');
      expect(config, isNot(contains('foo')));
    });
  });

  group('.toJson()', () {
    test('should return empty map for a newly created instance', () {
      var map = new Configuration().toJson();
      expect(map, allOf(isMap, isEmpty));
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = new Configuration({'foo': 'bar', 'bar': 'baz'}).toJson();
      expect(map, allOf(isMap, hasLength(2)));
      expect(map['foo'], equals('bar'));
      expect(map['bar'], equals('baz'));
    });
  });
});
