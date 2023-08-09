import 'package:flight_booking/core/end_points.dart';
import 'package:flight_booking/flight_search/service/base_client_service.dart';
import 'package:flight_booking/model/request/auto_suggest_request.dart';
import 'package:flight_booking/model/response/auto_suggest_response.dart';

import '../../model/request/flight_initial_data_request.dart';
import '../../model/response/flight_initial_data_response.dart';

class FlightSearchService {
  BaseClientService baseClientService = BaseClientService();

  Future<AutoSuggestResponse?> autoSuggestFlight(String searchTerm) async {
    AutoSuggestResponse? suggestions;
    List<String> includedEntityTypes = [
      "PLACE_TYPE_CITY",
      "PLACE_TYPE_AIRPORT"
    ];
    Query query = Query(
        market: 'UK',
        locale: 'en-GB',
        searchTerm: searchTerm,
        includedEntityTypes: includedEntityTypes);
    AutoSuggestRequest autoSuggestRequest = AutoSuggestRequest(query: query);
    var response = await baseClientService.post(
        EndPoints.autosuggest, autoSuggestRequestToJson(autoSuggestRequest));
    print('/////////////////////// Suggestion Response: $response');
    if (response != null) {
      suggestions = autoSuggestResponseFromJson(response);
    }
    return suggestions;
  }

  Future<FlightInitialDataResponse?> initiateFlightPrice(
      {required String originIata,
      required String destinationIata,
      required int year,
      required int month,
      required int day,
      required int adults,
      List<int>? childrenAges,
      required String cabinClass}) async {
    FlightInitialDataResponse? flightInitialDataResponse;
    NPlaceId originPlaceId = NPlaceId(iata: originIata);
    NPlaceId destinationPlaceId = NPlaceId(iata: destinationIata);
    Date date = Date(year: year, month: month, day: day);
    QueryLeg queryLeg = QueryLeg(
        originPlaceId: originPlaceId,
        destinationPlaceId: destinationPlaceId,
        date: date);
    List<QueryLeg> queryLegs = [queryLeg];
    FlightQuery flightQuery = FlightQuery(
        market: "IN",
        locale: "en-GB",
        currency: "INR",
        queryLegs: queryLegs,
        adults: adults,
        childrenAges: childrenAges!,
        cabinClass: cabinClass);
    FlightInitialDataRequest flightInitialDataRequest =
        FlightInitialDataRequest(query: flightQuery);
    var response = await baseClientService.post(EndPoints.initialFlightPrice,
        flightInitialDataRequestToJson(flightInitialDataRequest));
    print('/////////////////////// Flight Response: $response');
    if (response != null) {
      flightInitialDataResponse = flightInitialDataResponseFromJson(response);
    }
    return flightInitialDataResponse;
  }

  Future<FlightInitialDataResponse?> fullFlightPrice({required String sessionToken}) async {
    FlightInitialDataResponse? flightFullDataResponse;
    var response = await baseClientService
        .post('${EndPoints.fullFlightPrice}/$sessionToken');
    print('/////////////////////// Full Response: $response');
    if (response != null) {
      flightFullDataResponse = flightInitialDataResponseFromJson(response);
    }
    return flightFullDataResponse;
  }
}
