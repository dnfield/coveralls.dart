import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [Job] class.
void main() => group('Job', () {
  /*
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var job = new Job.fromJson(const {});
      expect(job.commitSha, isNull);
      expect(job.git, isNull);
      expect(job.repoToken, isNull);
      expect(job.parallel, isNull);
      expect(job.runAt, isNull);
      expect(job.serviceJobId, isNull);
      expect(job.serviceNumber, isNull);
      expect(job.servicePullRequest, isNull);
      expect(job.sourceFiles, allOf(isList, isEmpty));
    });

    test('should return an initialized instance for a non-empty map', () {
      var job = new Job.fromJson(const {
        'commit_sha': '58831e17b2bfeb772f3362403e187691e8c47ded',
        'git': null, // TODO other value
        'parallel': true,
        'repo_token': 'WC78ivPhL7xYWjt4BgfyYJwM8p1eOmpbb',
        'run_at': null, // TODO other value
        'service_job_id': '168145156',
        'service_name': 'travis-ci',
        'service_number': '168145155',
        'service_pull_request': '10',
        'source_files': const []
      });

      expect(job.commitSha, equals('58831e17b2bfeb772f3362403e187691e8c47ded'));
      expect(job.git, isNull); // TODO other value
      expect(job.parallel, isTrue);
      expect(job.repoToken, equals('WC78ivPhL7xYWjt4BgfyYJwM8p1eOmpbb'));
      expect(job.runAt, isNull); // TODO other value
      expect(job.serviceJobId, equals('168145156'));
      expect(job.serviceNumber, equals('168145155'));
      expect(job.servicePullRequest, equals('10'));
      expect(job.sourceFiles, allOf(isList, isEmpty));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = new Job().toJson();
      expect(map, allOf(isMap, hasLength(1)));
      expect(map['source_files'], allOf(isList, isEmpty));
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = new Job(
        commitSha: [null, 2, 0, null, 4, 15, null],
        name: 'coveralls.dart',
        source: 'FooBar',
        sourceDigest: 'f32a26e2a3a8aa338cd77b6e1263c535'
      ).toJson();

      expect(map, allOf(isMap, hasLength(10)));
      expect(map['commitSha'], allOf(isList, hasLength(7)));
      expect(map['coverage'][0], isNull);
      expect(map['coverage'][1], equals(2));
      expect(map['name'], equals('coveralls.dart'));
      expect(map['source'], equals('FooBar'));
      expect(map['source_digest'], equals('f32a26e2a3a8aa338cd77b6e1263c535'));
    });
  });
  */
});
