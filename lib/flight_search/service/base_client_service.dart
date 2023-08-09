import 'package:flight_booking/core/end_points.dart';
import 'package:http/http.dart';

class BaseClientService {
  static Client baseClient = Client();
  static String flightApiKey = EndPoints.flightApiKey;
  static Map<String, String> baseHeader = {
    'content-type': 'application/json',
    'x-api-key': flightApiKey,
  };

  Future<dynamic> post(String endpoint, [String? body]) async {
    var baseUrl = EndPoints.baseUrl;
    Uri url = Uri.parse('$baseUrl/$endpoint');
    print('/////////////// url, $url');
    print('/////////////// body, $body');
    Response response = await baseClient
        .post(url, headers: baseHeader, body: body)
        .timeout(const Duration(seconds: 20));
    if (response.statusCode == 200) {
      // print('//////////// responseBody: ${response.body}');
      return response.body;
    } else {
      print('///////// something went wrong');
    }
  }
}
