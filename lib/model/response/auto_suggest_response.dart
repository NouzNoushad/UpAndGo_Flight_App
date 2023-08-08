// To parse this JSON data, do
//
//     final autoSuggestResponse = autoSuggestResponseFromJson(jsonString);

import 'dart:convert';

AutoSuggestResponse autoSuggestResponseFromJson(String str) =>
    AutoSuggestResponse.fromJson(json.decode(str));

String autoSuggestResponseToJson(AutoSuggestResponse data) =>
    json.encode(data.toJson());

class AutoSuggestResponse {
  List<Place> places;

  AutoSuggestResponse({
    required this.places,
  });

  factory AutoSuggestResponse.fromJson(Map<String, dynamic> json) =>
      AutoSuggestResponse(
        places: List<Place>.from(json["places"].map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "places": List<dynamic>.from(places.map((x) => x.toJson())),
      };
}

class Place {
  String entityId;
  String? iataCode;
  String parentId;
  String name;
  String countryId;
  String countryName;
  String cityName;
  String location;
  String hierarchy;
  String type;
  List<List<int>> highlighting;

  Place({
    required this.entityId,
    this.iataCode,
    required this.parentId,
    required this.name,
    required this.countryId,
    required this.countryName,
    required this.cityName,
    required this.location,
    required this.hierarchy,
    required this.type,
    required this.highlighting,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        entityId: json["entityId"],
        iataCode: json["iataCode"],
        parentId: json["parentId"],
        name: json["name"],
        countryId: json["countryId"],
        countryName: json["countryName"],
        cityName: json["cityName"],
        location: json["location"],
        hierarchy: json["hierarchy"],
        type: json["type"],
        highlighting: List<List<int>>.from(
            json["highlighting"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "entityId": entityId,
        "iataCode": iataCode,
        "parentId": parentId,
        "name": name,
        "countryId": countryId,
        "countryName": countryName,
        "cityName": cityName,
        "location": location,
        "hierarchy": hierarchy,
        "type": type,
        "highlighting": List<dynamic>.from(
            highlighting.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

// enum Type { PLACE_TYPE_AIRPORT }

// final typeValues = EnumValues({"PLACE_TYPE_AIRPORT": Type.PLACE_TYPE_AIRPORT});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
