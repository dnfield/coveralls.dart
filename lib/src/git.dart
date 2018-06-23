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
  final String authorEmail;

  /// The author name.
  final String authorName;

  /// The committer mail address.
  final String committerEmail;

  /// The committer name.
  final String committerName;

  /// The commit identifier.
  final String id;

  /// The commit message.
  final String message;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{'id': id};
    if (authorEmail.isNotEmpty) map['author_email'] = authorEmail;
    if (authorName.isNotEmpty) map['author_name'] = authorName;
    if (committerEmail.isNotEmpty) map['committer_email'] = committerEmail;
    if (committerName.isNotEmpty) map['committer_name'] = committerName;
    if (message.isNotEmpty) map['message'] = message;
    return map;
  }

  /// Returns a [String] representation of this object.
  @override
  String toString() => 'GitCommit ${json.encode(this)}';
}

/// Represents Git data that can be used to display more information to users.
class GitData {

  /// Creates a new data.
  GitData(this.commit, {this.branch = '', Iterable<GitRemote> remotes}): remotes = List<GitRemote>.from(remotes ?? const <GitRemote>[]);

  /// Creates a new data from the specified [map] in JSON format.
  GitData.fromJson(Map<String, dynamic> map):
    branch = map['branch'] is String ? map['branch'] : '',
    commit = map['head'] is Map<String, String> ? GitCommit.fromJson(map['head']) : null,
    remotes = map['remotes'] is List<Map<String, String>> ? map['remotes'].map((item) => GitRemote.fromJson(item)).cast<GitRemote>().toList() : <GitRemote>[];

  /// The branch name.
  String branch;

  /// The Git commit.
  final GitCommit commit;

  /// The remote repositories.
  final List<GitRemote> remotes;

  /// Creates a new Git data from a repository located at the specified [path] (defaulting to the current working directory).
  /// This method relies on the availability of the Git executable in the system path.
  static Future<GitData> fromRepository([String path = '']) async {
    var commands = {
    'authorEmail': 'log -1 --pretty=format:%ae',
    'authorName': 'log -1 --pretty=format:%aN',
    'branch': 'rev-parse --abbrev-ref HEAD',
    'committerEmail': 'log -1 --pretty=format:%ce',
    'committerName': 'log -1 --pretty=format:%cN',
    'id': 'log -1 --pretty=format:%H',
    'message': 'log -1 --pretty=format:%s',
    'remotes': 'remote -v'
    };

    var workingDir = path.isNotEmpty ? path : Directory.current.path;
    for (var key in commands.keys) {
      var result = await Process.run('git', commands[key].split(' '), workingDirectory: workingDir);
      commands[key] = result.stdout.trim();
    }

    var remotes = <String, GitRemote>{};
    for (var remote in commands['remotes'].split(RegExp(r'\r?\n'))) {
      var parts = remote.replaceAll(RegExp(r'\s+'), ' ').split(' ');
      remotes.putIfAbsent(parts.first, () => GitRemote(parts.first, parts.length > 1 ? Uri.parse(parts[1]) : null));
    }

    return GitData(GitCommit.fromJson(commands), branch: commands['branch'], remotes: remotes.values);
  }

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => {
    'branch': branch,
    'head': commit?.toJson(),
    'remotes': remotes.map((item) => item.toJson()).toList()
  };

  /// Returns a [String] representation of this object.
  @override
  String toString() => 'GitData ${json.encode(this)}';
}

/// Represents a Git remote repository.
class GitRemote {

  /// Creates a new remote repository.
  GitRemote(this.name, [this.url]);

  /// Creates a new source file from the specified [map] in JSON format.
  GitRemote.fromJson(Map<String, String> map):
    name = map['name'] ?? '',
    url = map['url'] != null ? Uri.tryParse(map['url']) : null;

  /// The remote's name.
  final String name;

  /// The remote's URL.
  final Uri url;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url?.toString()
  };

  /// Returns a [String] representation of this object.
  @override
  String toString() => 'GitRemote ${json.encode(this)}';
}
