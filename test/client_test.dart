import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [Client] class.
void main() => group('Client', () {
  /*
  group('constructor', () {
    test('should return an instance with default values for an empty map', () {
      var job = new Client();
      expect(job.git, isNull);
      expect(job.isParallel, isFalse);
      expect(job.repoToken, isEmpty);
      expect(job.runAt, isNull);
      expect(job.sourceFiles, allOf(isList, isEmpty));
    });

    test('should return an initialized instance for a non-empty map', () {
      var job = new Client(new Configuration({
        'parallel': 'true',
        'repo_token': 'yYPv4mMlfjKgUK0rJPgN0AwNXhfzXpVwt',
        'run_at': '2017-01-29T02:43:30.000Z',
        'service_branch': 'develop'
      }), [new SourceFile('/home/cedx/coveralls.dart')]);

      expect(job.isParallel, isTrue);
      expect(job.repoToken, equals('yYPv4mMlfjKgUK0rJPgN0AwNXhfzXpVwt'));

      expect(job.git, new isInstanceOf<GitData>());
      expect(job.git.branch, equals('develop'));

      expect(job.runAt, new isInstanceOf<DateTime>());
      expect(job.runAt.toIso8601String(), equals('2017-01-29T02:43:30.000Z'));

      expect(job.sourceFiles, allOf(isList, hasLength(1)));
      expect(job.sourceFiles[0], new isInstanceOf<SourceFile>());
      expect(job.sourceFiles[0].name, equals('/home/cedx/coveralls.dart'));
    });
  });*/
});
