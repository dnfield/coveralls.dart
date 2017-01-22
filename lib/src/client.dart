part of coveralls;

/// Uploads code coverage reports to the [Coveralls](https://coveralls.io) service.
class Client {

  /// The URL of the API end point.
  static final Uri endPoint = Uri.parse('https://coveralls.io/api/v1/jobs');

  /// The stream of "request" events.
  Stream<MultipartRequest> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<Response> get onResponse => _onResponse.stream;

  /// The handler of "request" events.
  final StreamController<MultipartRequest> _onRequest = new StreamController<MultipartRequest>.broadcast();

  /// The handler of "response" events.
  final StreamController<Response> _onResponse = new StreamController<Response>.broadcast();

  /// Uploads the specified code [coverage] report in LCOV format to the Coveralls service.
  Future<Response> upload(String coverage) async {
    assert(coverage != null);
    var hitmap = await new Formatter().format(coverage);
    print(hitmap);

    var request = new MultipartRequest('POST', endPoint);
    request.files.add(new MultipartFile.fromString('json_file', JSON.encode(hitmap), filename: 'json_file'));
    _onRequest.add(request);

    var streamedResponse = await request.send();
    var response = await Response.fromStream(streamedResponse);
    _onResponse.add(response);

    if (response.statusCode != 200) throw new HttpException(response.reasonPhrase, uri: request.url);
    return response;
  }

  /// Uploads the specified code [coverage] report in LCOV format to the Coveralls service.
  Future<Response> uploadFile(File coverage) async {
    assert(coverage != null);
    if (!await coverage.exists())
      throw new ArgumentError.value(coverage, 'coverage', 'The specified file does not exist.');

    return upload(await coverage.readAsString());
  }
}
