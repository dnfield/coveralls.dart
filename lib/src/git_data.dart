part of coveralls;

/// Represents Git data that can be used to display more information to users.
class GitData {

  /// Creates a new data.
  GitData([this.commit, this.branch = '', List<GitRemote> remotes]): remotes = remotes ?? [];

  /// Creates a new data from the specified [map] in JSON format.
  GitData.fromJson(Map<String, dynamic> map):
    branch = map['branch'] is String ? map['branch'] : '',
    commit = map['head'] is Map<String, String> ? new GitCommit.fromJson(map['head']) : null,
    remotes = map['remotes'] is List<Map<String, String>> ? map['remotes'].map((item) => new GitRemote.fromJson(item)).toList() : [];

  /// The branch name.
  String branch;

  /// The Git commit.
  GitCommit commit;

  /// The remote repositories.
  final List<GitRemote> remotes;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'branch': branch,
    'head': commit?.toJson(),
    'remotes': remotes.map((item) => item.toJson()).toList()
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
