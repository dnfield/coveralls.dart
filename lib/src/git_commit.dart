part of coveralls;

/// Represents a Git remote repository.
class GitCommit {

  /// Creates a new remote repository.
  GitCommit([this.id = '', this.message = '']);

  /// Creates a new source file from the specified [map] in JSON format.
  GitCommit.fromJson(Map<String, String> map):
    authorEmail = map['author_email'] ?? '',
    authorName = map['author_name'] ?? '',
    committerEmail = map['committer_email'] ?? '',
    committerName = map['committer_name'] ?? '',
    id = map['id'] ?? '',
    message = map['message'] ?? '';

  /// The remote's name.
  String authorEmail = '';

  /// The remote's name.
  String authorName = '';

  /// The remote's name.
  String committerEmail = '';

  /// The remote's name.
  String committerName = '';

  /// The remote's name.
  String id;

  /// The remote's name.
  String message;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() {
    var map = {'id': id};
    if (authorEmail.isNotEmpty) map['author_email'] = authorEmail;
    if (authorName.isNotEmpty) map['author_name'] = authorName;
    if (committerEmail.isNotEmpty) map['committer_email'] = committerEmail;
    if (committerName.isNotEmpty) map['committer_name'] = committerName;
    if (message.isNotEmpty) map['message'] = message;
    return map;
  }

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
