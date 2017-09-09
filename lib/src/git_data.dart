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

  /// Creates a new Git data from a repository located at the specified [path] (defaulting to the current working directory).
  /// This method relies on the availability of the Git executable in the system path.
  static Future<GitData> fromRepository([String path = '']) async {
    var commands = {
      'authorEmail': "log -1 --pretty=format:'%ae'",
      'authorName': "log -1 --pretty=format:'%aN'",
      'branch': 'rev-parse --abbrev-ref HEAD',
      'committerEmail': "log -1 --pretty=format:'%ce'",
      'committerName': "log -1 --pretty=format:'%cN'",
      'id': "log -1 --pretty=format:'%H'",
      'message': "log -1 --pretty=format:'%s'",
      'remotes': 'remote -v'
    };

    var workingDir = path.isNotEmpty ? path : Directory.current.path;
    var futures = commands.keys.map((key) => Process.run('git', commands[key].split(' '), runInShell: true, workingDirectory: workingDir));
    var results = (await Future.wait(futures)).map((result) => result.stdout.trim().replaceAll(new RegExp(r"^'+|'+$"), '')).toList();

    var index = 0;
    for (var key in commands.keys) {
      commands[key] = results[index];
      index++;
    }

    var commit = new GitCommit(commands['id'], commands['message'])
      ..authorEmail = commands['authorEmail']
      ..authorName = commands['authorName']
      ..committerEmail = commands['committerEmail']
      ..committerName = commands['committerName'];

    var names = [];
    var remotes = <GitRemote>[];
    for (var remote in commands['remotes'].split(new RegExp(r'\r?\n'))) {
      var parts = remote.replaceAll(new RegExp(r'\s+'), ' ').split(' ');
      if (!names.contains(parts.first)) {
        names.add(parts.first);
        remotes.add(new GitRemote(parts.first, parts.length > 1 ? parts[1] : ''));
      }
    }

    return new GitData(commit, commands['branch'], remotes);
  }

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
