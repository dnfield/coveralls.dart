# Coveralls for Dart
Send [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage reports to the [Coveralls](https://coveralls.io) service.

## Requirements
The latest [Dart SDK](https://www.dartlang.org) and [Pub](https://pub.dartlang.org) versions.
If you plan to play with the sources, you will also need the latest [Grinder](http://google.github.io/grinder.dart) version.

## Installing via [Pub](https://pub.dartlang.org)

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
devDpendencies:
  coveralls: *
```

### 2. Install it
Install this package and its dependencies from a command prompt:

```shell
$ pub get
```

### 3. Import it
Now in your [Dart](https://www.dartlang.org) code, you can use:

```dart
import 'package:coveralls/coveralls.dart';
```

## Usage
TODO

## Supported CI services
- [AppVeyor](https://www.appveyor.com)
- [CircleCI](https://circleci.com)
- [Codeship](https://codeship.com)
- [GitLab CI](https://gitlab.com)
- [Jenkins](https://jenkins.io)
- [Semaphore](https://semaphoreci.com)
- [Surf](https://github.com/surf-build/surf)
- [Travis CI](https://travis-ci.com)
- [Wercker](http://www.wercker.com)

## See also
- [API reference](https://cedx.github.io/coveralls.dart)
- [Code coverage](https://coveralls.io/github/cedx/coveralls.dart)
- [Continuous integration](https://travis-ci.org/cedx/coveralls.dart)

## License
[Coveralls for Dart](https://github.com/cedx/coveralls.dart) is distributed under the Apache License, version 2.0.
