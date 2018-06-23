# Application programming interface
The hard way. Use the `Client` class to upload your coverage reports:

```dart
import 'dart:async';
import 'dart:io';
import 'package:coveralls/coveralls.dart';

Future<void> main() async {
  try {
    var coverage = File('/path/to/coverage.report');
    await Client().upload(await coverage.readAsString());
    print('The report was sent successfully.');
  }

  on ClientException catch (err) {
    print('An error occurred: $err');
  }
}
```

The `Client#upload()` method returns a [`Future`](https://api.dartlang.org/stable/dart-async/Future-class.html) that completes when the message has been sent.

The future completes with a `ClientException` if any error occurred while uploading the report.
