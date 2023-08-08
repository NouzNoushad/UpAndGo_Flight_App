// To parse this JSON data, do
//
//     final flightInitialDataRequest = flightInitialDataRequestFromJson(jsonString);

import 'dart:convert';

FlightInitialDataRequest flightInitialDataRequestFromJson(String str) =>
    FlightInitialDataRequest.fromJson(json.decode(str));

String flightInitialDataRequestToJson(FlightInitialDataRequest data) =>
    json.encode(data.toJson());

class FlightInitialDataRequest {
  FlightQuery query;

  FlightInitialDataRequest({
    required this.query,
  });

  factory FlightInitialDataRequest.fromJson(Map<String, dynamic> json) =>
      FlightInitialDataRequest(
        query: FlightQuery.fromJson(json["query"]),
      );

  Map<String, dynamic> toJson() => {
        "query": query.toJson(),
      };
}

class FlightQuery {
  String market;
  String locale;
  String currency;
  List<QueryLeg> queryLegs;
  int adults;
  List<int> childrenAges;
  String cabinClass;

  FlightQuery({
    required this.market,
    required this.locale,
    required this.currency,
    required this.queryLegs,
    required this.adults,
    required this.childrenAges,
    required this.cabinClass,
  });

  factory FlightQuery.fromJson(Map<String, dynamic> json) => FlightQuery(
        market: json["market"],
        locale: json["locale"],
        currency: json["currency"],
        queryLegs: List<QueryLeg>.from(
            json["query_legs"].map((x) => QueryLeg.fromJson(x))),
        adults: json["adults"],
        childrenAges: List<int>.from(json["childrenAges"].map((x) => x)),
        cabinClass: json["cabin_class"],
      );

  Map<String, dynamic> toJson() => {
        "market": market,
        "locale": locale,
        "currency": currency,
        "query_legs": List<dynamic>.from(queryLegs.map((x) => x.toJson())),
        "adults": adults,
        "childrenAges": List<dynamic>.from(childrenAges.map((x) => x)),
        "cabin_class": cabinClass,
      };
}

class QueryLeg {
  NPlaceId originPlaceId;
  NPlaceId destinationPlaceId;
  Date date;

  QueryLeg({
    required this.originPlaceId,
    required this.destinationPlaceId,
    required this.date,
  });

  factory QueryLeg.fromJson(Map<String, dynamic> json) => QueryLeg(
        originPlaceId: NPlaceId.fromJson(json["origin_place_id"]),
        destinationPlaceId: NPlaceId.fromJson(json["destination_place_id"]),
        date: Date.fromJson(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "origin_place_id": originPlaceId.toJson(),
        "destination_place_id": destinationPlaceId.toJson(),
        "date": date.toJson(),
      };
}

class Date {
  int year;
  int month;
  int day;

  Date({
    required this.year,
    required this.month,
    required this.day,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        year: json["year"],
        month: json["month"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
      };
}

class NPlaceId {
  String iata;

  NPlaceId({
    required this.iata,
  });

  factory NPlaceId.fromJson(Map<String, dynamic> json) => NPlaceId(
        iata: json["iata"],
      );

  Map<String, dynamic> toJson() => {
        "iata": iata,
      };
}
