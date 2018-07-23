part of coveralls.io;

/// Represents a source code file and its coverage data for a single job.
class SourceFile {

  /// Creates a new source file.
  SourceFile(this.name, this.sourceDigest, {Iterable<int> coverage, this.source = ''}):
    coverage = List<int>.from(coverage ?? const <int>[]);

  /// Creates a new source file from the specified [map] in JSON format.
  SourceFile.fromJson(Map<String, dynamic> map):
    coverage = map['coverage'] is List<int> ? map['coverage'] : [],
    name = map['name'] is String ? map['name'] : '',
    source = map['source'] is String ? map['source'] : '',
    sourceDigest = map['source_digest'] is String ? map['source_digest'] : '';

  /// The coverage data for this file's job.
  final List<int> coverage;

  /// The file path of this source file.
  final String name;

  /// The contents of this source file.
  final String source;

  /// The MD5 digest of the full source code of this file.
  final String sourceDigest;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{
      'name': name,
      'source_digest': sourceDigest,
      'coverage': coverage
    };

    if (source.isNotEmpty) map['source'] = source;
    return map;
  }

  /// Returns a [String] representation of this object.
  @override
  String toString() => 'SourceFile ${json.encode(this)}';
}
