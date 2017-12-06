import 'package:file/file.dart';
import 'package:http/http.dart' as http;
import 'package:nodejs_interop/nodejs_interop.dart' as node;
import 'package:platform/platform.dart';
import 'package:process/process.dart';

/// The command line arguments.
List<String> get arguments => node.process.argv.skip(2).toList();

/// The global exit code for the process.
int get exitCode => node.exitCode;
set exitCode(int value) => node.exitCode = value;

/// A reference to the file system.
const FileSystem fileSystem = const node.FileSystem();

/// A reference to the HTTP client.
final http.Client httpClient = null; // TODO: new node.HttpClient();

/// A reference to the platform.
const Platform platform = const node.Platform();

/// A reference to the process manager.
const ProcessManager processManager = const node.ProcessManager();
