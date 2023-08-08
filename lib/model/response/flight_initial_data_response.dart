// To parse this JSON data, do
//
//     final flightInitialDataResponse = flightInitialDataResponseFromJson(jsonString);

import 'dart:convert';

FlightInitialDataResponse flightInitialDataResponseFromJson(String str) =>
    FlightInitialDataResponse.fromJson(json.decode(str));

String flightInitialDataResponseToJson(FlightInitialDataResponse data) =>
    json.encode(data.toJson());

class FlightInitialDataResponse {
  String sessionToken;
  String status;
  String action;
  Content content;

  FlightInitialDataResponse({
    required this.sessionToken,
    required this.status,
    required this.action,
    required this.content,
  });

  factory FlightInitialDataResponse.fromJson(Map<String, dynamic> json) =>
      FlightInitialDataResponse(
        sessionToken: json["sessionToken"],
        status: json["status"],
        action: json["action"],
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "sessionToken": sessionToken,
        "status": status,
        "action": action,
        "content": content.toJson(),
      };
}

class Content {
  Results results;
  Stats stats;
  SortingOptions sortingOptions;

  Content({
    required this.results,
    required this.stats,
    required this.sortingOptions,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        results: Results.fromJson(json["results"]),
        stats: Stats.fromJson(json["stats"]),
        sortingOptions: SortingOptions.fromJson(json["sortingOptions"]),
      );

  Map<String, dynamic> toJson() => {
        "results": results.toJson(),
        "stats": stats.toJson(),
        "sortingOptions": sortingOptions.toJson(),
      };
}

class Results {
  Map<String, Itinerary> itineraries;
  Map<String, Leg> legs;
  Map<String, Segment> segments;
  Map<String, Place> places;
  Map<String, Carrier> carriers;
  Map<String, Agent> agents;
  Alliances alliances;

  Results({
    required this.itineraries,
    required this.legs,
    required this.segments,
    required this.places,
    required this.carriers,
    required this.agents,
    required this.alliances,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        itineraries: Map.from(json["itineraries"]).map(
            (k, v) => MapEntry<String, Itinerary>(k, Itinerary.fromJson(v))),
        legs: Map.from(json["legs"])
            .map((k, v) => MapEntry<String, Leg>(k, Leg.fromJson(v))),
        segments: Map.from(json["segments"])
            .map((k, v) => MapEntry<String, Segment>(k, Segment.fromJson(v))),
        places: Map.from(json["places"])
            .map((k, v) => MapEntry<String, Place>(k, Place.fromJson(v))),
        carriers: Map.from(json["carriers"])
            .map((k, v) => MapEntry<String, Carrier>(k, Carrier.fromJson(v))),
        agents: Map.from(json["agents"])
            .map((k, v) => MapEntry<String, Agent>(k, Agent.fromJson(v))),
        alliances: Alliances.fromJson(json["alliances"]),
      );

  Map<String, dynamic> toJson() => {
        "itineraries": Map.from(itineraries)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "legs": Map.from(legs)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "segments": Map.from(segments)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "places": Map.from(places)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "carriers": Map.from(carriers)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "agents": Map.from(agents)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "alliances": alliances.toJson(),
      };
}

class Agent {
  String name;
  Type type;
  String imageUrl;
  int feedbackCount;
  double rating;
  RatingBreakdown? ratingBreakdown;
  bool isOptimisedForMobile;

  Agent({
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.feedbackCount,
    required this.rating,
    this.ratingBreakdown,
    required this.isOptimisedForMobile,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        name: json["name"],
        type: typeValues.map[json["type"]]!,
        imageUrl: json["imageUrl"],
        feedbackCount: json["feedbackCount"],
        rating: json["rating"]?.toDouble(),
        ratingBreakdown: json["ratingBreakdown"] == null
            ? null
            : RatingBreakdown.fromJson(json["ratingBreakdown"]),
        isOptimisedForMobile: json["isOptimisedForMobile"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": typeValues.reverse[type],
        "imageUrl": imageUrl,
        "feedbackCount": feedbackCount,
        "rating": rating,
        "ratingBreakdown": ratingBreakdown?.toJson(),
        "isOptimisedForMobile": isOptimisedForMobile,
      };
}

class RatingBreakdown {
  int customerService;
  int reliablePrices;
  int clearExtraFees;
  int easeOfBooking;
  int other;

  RatingBreakdown({
    required this.customerService,
    required this.reliablePrices,
    required this.clearExtraFees,
    required this.easeOfBooking,
    required this.other,
  });

  factory RatingBreakdown.fromJson(Map<String, dynamic> json) =>
      RatingBreakdown(
        customerService: json["customerService"],
        reliablePrices: json["reliablePrices"],
        clearExtraFees: json["clearExtraFees"],
        easeOfBooking: json["easeOfBooking"],
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "customerService": customerService,
        "reliablePrices": reliablePrices,
        "clearExtraFees": clearExtraFees,
        "easeOfBooking": easeOfBooking,
        "other": other,
      };
}

enum Type { AGENT_TYPE_AIRLINE, AGENT_TYPE_TRAVEL_AGENT }

final typeValues = EnumValues({
  "AGENT_TYPE_AIRLINE": Type.AGENT_TYPE_AIRLINE,
  "AGENT_TYPE_TRAVEL_AGENT": Type.AGENT_TYPE_TRAVEL_AGENT
});

class Alliances {
  Alliances();

  factory Alliances.fromJson(Map<String, dynamic> json) => Alliances();

  Map<String, dynamic> toJson() => {};
}

class Carrier {
  String name;
  String allianceId;
  String imageUrl;
  String iata;
  String icao;
  String displayCode;

  Carrier({
    required this.name,
    required this.allianceId,
    required this.imageUrl,
    required this.iata,
    required this.icao,
    required this.displayCode,
  });

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
        name: json["name"],
        allianceId: json["allianceId"],
        imageUrl: json["imageUrl"],
        iata: json["iata"],
        icao: json["icao"],
        displayCode: json["displayCode"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "allianceId": allianceId,
        "imageUrl": imageUrl,
        "iata": iata,
        "icao": icao,
        "displayCode": displayCode,
      };
}

class Itinerary {
  List<PricingOption> pricingOptions;
  List<String> legIds;
  dynamic sustainabilityData;

  Itinerary({
    required this.pricingOptions,
    required this.legIds,
    this.sustainabilityData,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        pricingOptions: List<PricingOption>.from(
            json["pricingOptions"].map((x) => PricingOption.fromJson(x))),
        legIds: List<String>.from(json["legIds"].map((x) => x)),
        sustainabilityData: json["sustainabilityData"],
      );

  Map<String, dynamic> toJson() => {
        "pricingOptions":
            List<dynamic>.from(pricingOptions.map((x) => x.toJson())),
        "legIds": List<dynamic>.from(legIds.map((x) => x)),
        "sustainabilityData": sustainabilityData,
      };
}

class PricingOption {
  Price price;
  List<AgentId> agentIds;
  List<Item> items;
  TransferType transferType;
  String id;
  dynamic pricingOptionFare;

  PricingOption({
    required this.price,
    required this.agentIds,
    required this.items,
    required this.transferType,
    required this.id,
    this.pricingOptionFare,
  });

  factory PricingOption.fromJson(Map<String, dynamic> json) => PricingOption(
        price: Price.fromJson(json["price"]),
        agentIds: List<AgentId>.from(
            json["agentIds"].map((x) => agentIdValues.map[x]!)),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        transferType: transferTypeValues.map[json["transferType"]]!,
        id: json["id"],
        pricingOptionFare: json["pricingOptionFare"],
      );

  Map<String, dynamic> toJson() => {
        "price": price.toJson(),
        "agentIds":
            List<dynamic>.from(agentIds.map((x) => agentIdValues.reverse[x])),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "transferType": transferTypeValues.reverse[transferType],
        "id": id,
        "pricingOptionFare": pricingOptionFare,
      };
}

enum AgentId { EMTI, GOIB, GTIN }

final agentIdValues = EnumValues(
    {"emti": AgentId.EMTI, "goib": AgentId.GOIB, "gtin": AgentId.GTIN});

class Item {
  Price price;
  AgentId agentId;
  String deepLink;
  List<Fare> fares;

  Item({
    required this.price,
    required this.agentId,
    required this.deepLink,
    required this.fares,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        price: Price.fromJson(json["price"]),
        agentId: agentIdValues.map[json["agentId"]]!,
        deepLink: json["deepLink"],
        fares: List<Fare>.from(json["fares"].map((x) => Fare.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "price": price.toJson(),
        "agentId": agentIdValues.reverse[agentId],
        "deepLink": deepLink,
        "fares": List<dynamic>.from(fares.map((x) => x.toJson())),
      };
}

class Fare {
  String segmentId;
  BookingCode bookingCode;
  String fareBasisCode;

  Fare({
    required this.segmentId,
    required this.bookingCode,
    required this.fareBasisCode,
  });

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
        segmentId: json["segmentId"],
        bookingCode: bookingCodeValues.map[json["bookingCode"]]!,
        fareBasisCode: json["fareBasisCode"],
      );

  Map<String, dynamic> toJson() => {
        "segmentId": segmentId,
        "bookingCode": bookingCodeValues.reverse[bookingCode],
        "fareBasisCode": fareBasisCode,
      };
}

enum BookingCode { EMPTY, P }

final bookingCodeValues =
    EnumValues({"": BookingCode.EMPTY, "P": BookingCode.P});

class Price {
  String amount;
  Unit unit;
  UpdateStatus updateStatus;

  Price({
    required this.amount,
    required this.unit,
    required this.updateStatus,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"],
        unit: unitValues.map[json["unit"]]!,
        updateStatus: updateStatusValues.map[json["updateStatus"]]!,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "unit": unitValues.reverse[unit],
        "updateStatus": updateStatusValues.reverse[updateStatus],
      };
}

enum Unit { PRICE_UNIT_MILLI, PRICE_UNIT_UNSPECIFIED }

final unitValues = EnumValues({
  "PRICE_UNIT_MILLI": Unit.PRICE_UNIT_MILLI,
  "PRICE_UNIT_UNSPECIFIED": Unit.PRICE_UNIT_UNSPECIFIED
});

enum UpdateStatus { PRICE_UPDATE_STATUS_UNSPECIFIED }

final updateStatusValues = EnumValues({
  "PRICE_UPDATE_STATUS_UNSPECIFIED":
      UpdateStatus.PRICE_UPDATE_STATUS_UNSPECIFIED
});

enum TransferType {
  TRANSFER_TYPE_MANAGED,
  TRANSFER_TYPE_PROTECTED_SELF_TRANSFER
}

final transferTypeValues = EnumValues({
  "TRANSFER_TYPE_MANAGED": TransferType.TRANSFER_TYPE_MANAGED,
  "TRANSFER_TYPE_PROTECTED_SELF_TRANSFER":
      TransferType.TRANSFER_TYPE_PROTECTED_SELF_TRANSFER
});

class Leg {
  String originPlaceId;
  String destinationPlaceId;
  DateTime departureDateTime;
  DateTime arrivalDateTime;
  int durationInMinutes;
  int stopCount;
  List<String> marketingCarrierIds;
  List<String> operatingCarrierIds;
  List<String> segmentIds;

  Leg({
    required this.originPlaceId,
    required this.destinationPlaceId,
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.durationInMinutes,
    required this.stopCount,
    required this.marketingCarrierIds,
    required this.operatingCarrierIds,
    required this.segmentIds,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        originPlaceId: json["originPlaceId"],
        destinationPlaceId: json["destinationPlaceId"],
        departureDateTime: DateTime.fromJson(json["departureDateTime"]),
        arrivalDateTime: DateTime.fromJson(json["arrivalDateTime"]),
        durationInMinutes: json["durationInMinutes"],
        stopCount: json["stopCount"],
        marketingCarrierIds:
            List<String>.from(json["marketingCarrierIds"].map((x) => x)),
        operatingCarrierIds:
            List<String>.from(json["operatingCarrierIds"].map((x) => x)),
        segmentIds: List<String>.from(json["segmentIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "originPlaceId": originPlaceId,
        "destinationPlaceId": destinationPlaceId,
        "departureDateTime": departureDateTime.toJson(),
        "arrivalDateTime": arrivalDateTime.toJson(),
        "durationInMinutes": durationInMinutes,
        "stopCount": stopCount,
        "marketingCarrierIds":
            List<dynamic>.from(marketingCarrierIds.map((x) => x)),
        "operatingCarrierIds":
            List<dynamic>.from(operatingCarrierIds.map((x) => x)),
        "segmentIds": List<dynamic>.from(segmentIds.map((x) => x)),
      };
}

class DateTime {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;

  DateTime({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });

  factory DateTime.fromJson(Map<String, dynamic> json) => DateTime(
        year: json["year"],
        month: json["month"],
        day: json["day"],
        hour: json["hour"],
        minute: json["minute"],
        second: json["second"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
        "hour": hour,
        "minute": minute,
        "second": second,
      };
}

class Place {
  String entityId;
  String parentId;
  String name;
  String type;
  String iata;
  dynamic coordinates;

  Place({
    required this.entityId,
    required this.parentId,
    required this.name,
    required this.type,
    required this.iata,
    this.coordinates,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        entityId: json["entityId"],
        parentId: json["parentId"],
        name: json["name"],
        type: json["type"],
        iata: json["iata"],
        coordinates: json["coordinates"],
      );

  Map<String, dynamic> toJson() => {
        "entityId": entityId,
        "parentId": parentId,
        "name": name,
        "type": type,
        "iata": iata,
        "coordinates": coordinates,
      };
}

class Segment {
  String originPlaceId;
  String destinationPlaceId;
  DateTime departureDateTime;
  DateTime arrivalDateTime;
  int durationInMinutes;
  String marketingFlightNumber;
  String marketingCarrierId;
  String operatingCarrierId;

  Segment({
    required this.originPlaceId,
    required this.destinationPlaceId,
    required this.departureDateTime,
    required this.arrivalDateTime,
    required this.durationInMinutes,
    required this.marketingFlightNumber,
    required this.marketingCarrierId,
    required this.operatingCarrierId,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        originPlaceId: json["originPlaceId"],
        destinationPlaceId: json["destinationPlaceId"],
        departureDateTime: DateTime.fromJson(json["departureDateTime"]),
        arrivalDateTime: DateTime.fromJson(json["arrivalDateTime"]),
        durationInMinutes: json["durationInMinutes"],
        marketingFlightNumber: json["marketingFlightNumber"],
        marketingCarrierId: json["marketingCarrierId"],
        operatingCarrierId: json["operatingCarrierId"],
      );

  Map<String, dynamic> toJson() => {
        "originPlaceId": originPlaceId,
        "destinationPlaceId": destinationPlaceId,
        "departureDateTime": departureDateTime.toJson(),
        "arrivalDateTime": arrivalDateTime.toJson(),
        "durationInMinutes": durationInMinutes,
        "marketingFlightNumber": marketingFlightNumber,
        "marketingCarrierId": marketingCarrierId,
        "operatingCarrierId": operatingCarrierId,
      };
}

class SortingOptions {
  List<Est> best;
  List<Est> cheapest;
  List<Est> fastest;

  SortingOptions({
    required this.best,
    required this.cheapest,
    required this.fastest,
  });

  factory SortingOptions.fromJson(Map<String, dynamic> json) => SortingOptions(
        best: List<Est>.from(json["best"].map((x) => Est.fromJson(x))),
        cheapest: List<Est>.from(json["cheapest"].map((x) => Est.fromJson(x))),
        fastest: List<Est>.from(json["fastest"].map((x) => Est.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "best": List<dynamic>.from(best.map((x) => x.toJson())),
        "cheapest": List<dynamic>.from(cheapest.map((x) => x.toJson())),
        "fastest": List<dynamic>.from(fastest.map((x) => x.toJson())),
      };
}

class Est {
  double score;
  String itineraryId;

  Est({
    required this.score,
    required this.itineraryId,
  });

  factory Est.fromJson(Map<String, dynamic> json) => Est(
        score: json["score"]?.toDouble(),
        itineraryId: json["itineraryId"],
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "itineraryId": itineraryId,
      };
}

class Stats {
  Itineraries itineraries;

  Stats({
    required this.itineraries,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        itineraries: Itineraries.fromJson(json["itineraries"]),
      );

  Map<String, dynamic> toJson() => {
        "itineraries": itineraries.toJson(),
      };
}

class Itineraries {
  int minDuration;
  int maxDuration;
  Total total;
  Stops stops;
  bool hasChangeAirportTransfer;

  Itineraries({
    required this.minDuration,
    required this.maxDuration,
    required this.total,
    required this.stops,
    required this.hasChangeAirportTransfer,
  });

  factory Itineraries.fromJson(Map<String, dynamic> json) => Itineraries(
        minDuration: json["minDuration"],
        maxDuration: json["maxDuration"],
        total: Total.fromJson(json["total"]),
        stops: Stops.fromJson(json["stops"]),
        hasChangeAirportTransfer: json["hasChangeAirportTransfer"],
      );

  Map<String, dynamic> toJson() => {
        "minDuration": minDuration,
        "maxDuration": maxDuration,
        "total": total.toJson(),
        "stops": stops.toJson(),
        "hasChangeAirportTransfer": hasChangeAirportTransfer,
      };
}

class Stops {
  Direct direct;
  Direct oneStop;
  Direct twoPlusStops;

  Stops({
    required this.direct,
    required this.oneStop,
    required this.twoPlusStops,
  });

  factory Stops.fromJson(Map<String, dynamic> json) => Stops(
        direct: Direct.fromJson(json["direct"]),
        oneStop: Direct.fromJson(json["oneStop"]),
        twoPlusStops: Direct.fromJson(json["twoPlusStops"]),
      );

  Map<String, dynamic> toJson() => {
        "direct": direct.toJson(),
        "oneStop": oneStop.toJson(),
        "twoPlusStops": twoPlusStops.toJson(),
      };
}

class Direct {
  Total total;
  TicketTypes ticketTypes;

  Direct({
    required this.total,
    required this.ticketTypes,
  });

  factory Direct.fromJson(Map<String, dynamic> json) => Direct(
        total: Total.fromJson(json["total"]),
        ticketTypes: TicketTypes.fromJson(json["ticketTypes"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total.toJson(),
        "ticketTypes": ticketTypes.toJson(),
      };
}

class TicketTypes {
  Total singleTicket;
  Total multiTicketNonNpt;
  Total multiTicketNpt;

  TicketTypes({
    required this.singleTicket,
    required this.multiTicketNonNpt,
    required this.multiTicketNpt,
  });

  factory TicketTypes.fromJson(Map<String, dynamic> json) => TicketTypes(
        singleTicket: Total.fromJson(json["singleTicket"]),
        multiTicketNonNpt: Total.fromJson(json["multiTicketNonNpt"]),
        multiTicketNpt: Total.fromJson(json["multiTicketNpt"]),
      );

  Map<String, dynamic> toJson() => {
        "singleTicket": singleTicket.toJson(),
        "multiTicketNonNpt": multiTicketNonNpt.toJson(),
        "multiTicketNpt": multiTicketNpt.toJson(),
      };
}

class Total {
  int count;
  Price minPrice;

  Total({
    required this.count,
    required this.minPrice,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        count: json["count"],
        minPrice: Price.fromJson(json["minPrice"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "minPrice": minPrice.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
