part of '../io.dart';

/// Represents a source code file and its coverage data for a single job.
@JsonSerializable()
class SourceFile {

  /// Creates a new source file.
  SourceFile(this.name, this.sourceDigest, {Iterable<int> coverage, this.source}):
    coverage = List<int>.from(coverage ?? const <int>[]);

  /// Creates a new source file from the specified [map] in JSON format.
  factory SourceFile.fromJson(Map<String, dynamic> map) => _$SourceFileFromJson(map);

  /// The coverage data for this file's job.
  final List<int> coverage;

  /// The file path of this source file.
  @JsonKey(defaultValue: '')
  final String name;

  /// The contents of this source file.
  @JsonKey(includeIfNull: false)
  final String source;

  /// The MD5 digest of the full source code of this file.
  @JsonKey(defaultValue: '', name: 'source_digest')
  final String sourceDigest;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$SourceFileToJson(this);

  /// Returns a [String] representation of this object.
  @override
  String toString() => 'SourceFile ${json.encode(this)}';
}
