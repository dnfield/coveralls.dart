part of coveralls;

/// Represents a Git commit.
class GitCommit {

  /// Creates a new commit.
  const GitCommit(this.id, {this.authorEmail = '', this.authorName = '', this.committerEmail = '', this.committerName = '', this.message = ''});

  /// Creates a new commit from the specified [map] in JSON format.
  GitCommit.fromJson(Map<String, String> map):
    authorEmail = map['author_email'] ?? '',
    authorName = map['author_name'] ?? '',
    committerEmail = map['committer_email'] ?? '',
    committerName = map['committer_name'] ?? '',
    id = map['id'] ?? '',
    message = map['message'] ?? '';

  /// The author mail address.
  String authorEmail = '';

  /// The author name.
  String authorName = '';

  /// The committer mail address.
  String committerEmail = '';

  /// The committer name.
  String committerName = '';

  /// The commit identifier.
  String id;

  /// The commit message.
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
