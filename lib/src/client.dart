part of coveralls;

/// Uploads code coverage reports to the [Coveralls](https://coveralls.io) service.
class Client {

  /// The URL of the API end point.
  static final Uri endPoint = Uri.parse('https://coveralls.io/api/v1/jobs');

  /// The stream of "request" events.
  Stream<http.Request> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<http.Response> get onResponse => _onResponse.stream;

  /// The handler of "request" events.
  final StreamController<http.Request> _onRequest = new StreamController<http.Request>.broadcast();

  /// The handler of "response" events.
  final StreamController<http.Response> _onResponse = new StreamController<http.Response>.broadcast();

  /// Uploads the specified code [coverage] report in LCOV format to the Coveralls service.
  Future<http.Response> upload(String coverage) async {
    assert(coverage != null);

    var hitmap = await new Formatter().format(coverage);
    print(hitmap);
    return null;

    var fields = {'json_file': JSON.encode(hitmap)};
    var request = new http.Request('POST', endPoint)..bodyFields = fields;
    _onRequest.add(request);

    var response = await http.post(request.url, body: request.bodyFields);
    _onResponse.add(response);
    return response;
  }

  /// Uploads the specified code [coverage] report in LCOV format to the Coveralls service.
  Future<http.Response> uploadFile(File coverage) async {
    assert(coverage != null);
    if (!await coverage.exists())
      throw new ArgumentError.value(coverage, 'coverage', 'The specified file does not exist.');

    return upload(await coverage.readAsString());
  }
}
