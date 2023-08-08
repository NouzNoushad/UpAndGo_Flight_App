// To parse this JSON data, do
//
//     final autoSuggestRequest = autoSuggestRequestFromJson(jsonString);

import 'dart:convert';

AutoSuggestRequest autoSuggestRequestFromJson(String str) =>
    AutoSuggestRequest.fromJson(json.decode(str));

String autoSuggestRequestToJson(AutoSuggestRequest data) =>
    json.encode(data.toJson());

class AutoSuggestRequest {
  Query query;

  AutoSuggestRequest({
    required this.query,
  });

  factory AutoSuggestRequest.fromJson(Map<String, dynamic> json) =>
      AutoSuggestRequest(
        query: Query.fromJson(json["query"]),
      );

  Map<String, dynamic> toJson() => {
        "query": query.toJson(),
      };
}

class Query {
  String market;
  String locale;
  String searchTerm;
  List<String> includedEntityTypes;

  Query({
    required this.market,
    required this.locale,
    required this.searchTerm,
    required this.includedEntityTypes,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        market: json["market"],
        locale: json["locale"],
        searchTerm: json["searchTerm"],
        includedEntityTypes:
            List<String>.from(json["includedEntityTypes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "market": market,
        "locale": locale,
        "searchTerm": searchTerm,
        "includedEntityTypes":
            List<dynamic>.from(includedEntityTypes.map((x) => x)),
      };
}
