part of coveralls;

/// Uploads code coverage reports to the [Coveralls](https://coveralls.io) service.
class Client {

  /// The URL of the API end point.
  static final Uri defaultEndPoint = Uri.parse('https://coveralls.io/api/v1/jobs');

  /// Creates a new client.
  Client([endPoint]) {
    if (endPoint != null) this.endPoint = endPoint is Uri ? endPoint : Uri.parse(endPoint.toString());
  }

  /// The URL of the API end point.
  Uri endPoint;

  /// The stream of "request" events.
  Stream<MultipartRequest> get onRequest => _onRequest.stream;

  /// The stream of "response" events.
  Stream<Response> get onResponse => _onResponse.stream;

  /// The handler of "request" events.
  final StreamController<MultipartRequest> _onRequest = new StreamController<MultipartRequest>.broadcast();

  /// The handler of "response" events.
  final StreamController<Response> _onResponse = new StreamController<Response>.broadcast();

  /// Uploads the specified code [coverage] report to the Coveralls service.
  Future upload(String coverage, [Configuration configuration]) async {
    assert(coverage != null);

    // Parse the coverage.
    var config = await (configuration != null ? new Future.value(configuration) : Configuration.loadDefaults());


    // Apply the configuration settings.
    var request = new MultipartRequest('POST', endPoint);
    request.files.add(new MultipartFile.fromString('json_file', JSON.encode(job), filename: 'json_file'));
    _onRequest.add(request);

    var streamedResponse = await request.send();
    var response = await Response.fromStream(streamedResponse);
    _onResponse.add(response);

    if (response.statusCode != 200) throw new HttpException(response.reasonPhrase, uri: request.url);
    return response;
  }

  /// Uploads the specified [job] to the Coveralls service.
  Future uploadJob(Job job) async {
    assert(job != null);
    // TODO
  }
}
