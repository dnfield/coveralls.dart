import 'package:coveralls/coveralls.dart';
import 'package:test/test.dart';

/// Tests the features of the [SourceFile] class.
void main() => group('SourceFile', () {
  group('.fromJson()', () {
    test('should return an instance with default values for an empty map', () {
      var file = new SourceFile.fromJson(const {});
      expect(file.coverage, allOf(isList, isEmpty));
      expect(file.name, isNull);
      expect(file.source, isNull);
      expect(file.sourceDigest, isNull);
    });

    test('should return an initialized instance for a non-empty map', () {
      var file = new SourceFile.fromJson(const {
        'coverage': const [null, 2, 0, null, 4, 15, null],
        'name': 'coveralls.dart',
        'source': 'FooBar',
        'source_digest': 'f32a26e2a3a8aa338cd77b6e1263c535'
      });

      expect(file.coverage, allOf(isList, hasLength(7)));
      expect(file.coverage[0], isNull);
      expect(file.coverage[1], equals(2));
      expect(file.name, equals('coveralls.dart'));
      expect(file.source, equals('FooBar'));
      expect(file.sourceDigest, equals('f32a26e2a3a8aa338cd77b6e1263c535'));
    });
  });

  group('.toJson()', () {
    test('should return a map with default values for a newly created instance', () {
      var map = new SourceFile().toJson();
      expect(map, allOf(isMap, hasLength(3)));
      expect(map['coverage'], allOf(isList, isEmpty));
      expect(map['name'], isNull);
      expect(map['source'], isNull);
    });

    test('should return a non-empty map for an initialized instance', () {
      var map = new SourceFile(
        coverage: [null, 2, 0, null, 4, 15, null],
        name: 'coveralls.dart',
        source: 'FooBar',
        sourceDigest: 'f32a26e2a3a8aa338cd77b6e1263c535'
      ).toJson();

      expect(map, allOf(isMap, hasLength(4)));
      expect(map['coverage'], allOf(isList, hasLength(7)));
      expect(map['coverage'][0], isNull);
      expect(map['coverage'][1], equals(2));
      expect(map['name'], equals('coveralls.dart'));
      expect(map['source'], equals('FooBar'));
      expect(map['source_digest'], equals('f32a26e2a3a8aa338cd77b6e1263c535'));
    });
  });
});
