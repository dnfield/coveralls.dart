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
        'source': 'void main() {}',
        'source_digest': '27f5ebf0f8c559b2af9419d190299a5e'
      });

      expect(file.coverage, allOf(isList, hasLength(7)));
      expect(file.coverage[0], isNull);
      expect(file.coverage[1], equals(2));
      expect(file.name, equals('coveralls.dart'));
      expect(file.source, equals('void main() {}'));
      expect(file.sourceDigest, equals('27f5ebf0f8c559b2af9419d190299a5e'));
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
        source: 'void main() {}',
        sourceDigest: '27f5ebf0f8c559b2af9419d190299a5e'
      ).toJson();

      expect(map, allOf(isMap, hasLength(4)));
      expect(map['coverage'], allOf(isList, hasLength(7)));
      expect(map['coverage'][0], isNull);
      expect(map['coverage'][1], equals(2));
      expect(map['name'], equals('coveralls.dart'));
      expect(map['source'], equals('void main() {}'));
      expect(map['source_digest'], equals('27f5ebf0f8c559b2af9419d190299a5e'));
    });
  });
});
