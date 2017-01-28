import 'configuration_test.dart' as configuration_test;
import 'git_commit_test.dart' as git_commit_test;
import 'git_data_test.dart' as git_data_test;
import 'git_remote_test.dart' as git_remote_test;
import 'source_file_test.dart' as source_file_test;

/// Tests all the features of the package.
void main() {
  configuration_test.main();
  git_commit_test.main();
  git_data_test.main();
  git_remote_test.main();
  source_file_test.main();
}
