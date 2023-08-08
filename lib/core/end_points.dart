import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints {
  static const String baseUrl =
      'https://partners.api.skyscanner.net/apiservices/v3';
  static String flightApiKey = dotenv.env['FLIGHT_API_KEY'].toString();
  static const String autosuggest = 'autosuggest/flights';
  static const String initialFlightPrice = 'flights/live/search/create';
  static const String fullFlightPrice = 'flights/live/search/poll';
}
// https://partners.api.skyscanner.net/apiservices/v3/autosuggest/flights
// https://partners.api.skyscanner.net/apiservices/v3/flights/live/search/create
// https://partners.api.skyscanner.net/apiservices/v3/flights/live/search/poll/{sessionToken}