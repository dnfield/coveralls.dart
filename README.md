# Coveralls for Dart
TODO

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

### The easy way
The simplest way to collect and upload your coverage data is to use the [dedicated set of functions](https://github.com/cedx/coveralls.dart/blob/master/lib/coveralls.dart).

#### 1. Collect the code coverage

```dart
@Task('Collects the coverage data and saves it as LCOV format')
void coverageCollect() => collectCoverage('test/all.dart', 'lcov.info');
```

#### 2. Upload the coverage report

```dart
@Task('Uploads the LCOV coverage report to Coveralls')
@Depends(coverageCollect)
void coverageUpload() => uploadCoverage('lcov.info');
```

### The hard way
TODO

## See also
- [API reference](https://cedx.github.io/coveralls.dart)
- [Code coverage](https://coveralls.io/github/cedx/coveralls.dart)
- [Continuous integration](https://travis-ci.org/cedx/coveralls.dart)

## License
[Coveralls for Dart](https://github.com/cedx/coveralls.dart) is distributed under the Apache License, version 2.0.
