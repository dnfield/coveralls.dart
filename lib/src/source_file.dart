part of coveralls;

/// Represents a source code file and its coverage data for a single job.
class SourceFile {

  /// Creates a new source file.
  SourceFile({List<int> coverage, this.name, this.sourceDigest}): coverage = coverage ?? [];

  /// The coverage data for the file's job.
  final List<int> coverage;

  /// The file path of this source file.
  String name;

  /// The contents of the source file.
  String source;

  /// The MD5 digest of the full source code of this file.
  String sourceDigest;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() {
    var map = {
      'name': name,
      'source_digest': sourceDigest,
      'coverage': coverage
    };

    if (source != null) map['source'] = source;
    return map;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
