part of coveralls;

/// Represents a Git remote repository.
class GitRemote {

  /// Creates a new remote repository.
  GitRemote([this.name = '', url]) {
    if (url != null) this.url = url is Uri ? url : Uri.parse(url.toString());
  }

  /// Creates a new source file from the specified [map] in JSON format.
  GitRemote.fromJson(Map<String, String> map):
    name = map['name'] ?? '',
    url = map['url'] != null ? Uri.parse(map['url']) : null;

  /// The remote's name.
  String name;

  /// The remote's URL.
  Uri url;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url?.toString()
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}
