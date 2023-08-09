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
  Results? results;
  Stats? stats;
  SortingOptions? sortingOptions;

  Content({
    this.results,
    this.stats,
    this.sortingOptions,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        results: Results.fromJson(json["results"]),
        stats: Stats.fromJson(json["stats"]),
        sortingOptions: SortingOptions.fromJson(json["sortingOptions"]),
      );

  Map<String, dynamic> toJson() => {
        "results": results?.toJson(),
        "stats": stats?.toJson(),
        "sortingOptions": sortingOptions?.toJson(),
      };
}

class Results {
  Map<String, Itinerary> itineraries;
  Map<String, Leg> legs;
  Map<String, Segment> segments;
  Map<String, FlightPlace> places;
  Map<String, Carrier> carriers;
  Map<String, Agent> agents;
  Alliances? alliances;

  Results({
    this.itineraries = const {},
    this.legs = const {},
    this.segments = const {},
    this.places = const {},
    this.carriers = const {},
    this.agents = const {},
    this.alliances,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        itineraries: Map.from(json["itineraries"]).map(
            (k, v) => MapEntry<String, Itinerary>(k, Itinerary.fromJson(v))),
        legs: Map.from(json["legs"])
            .map((k, v) => MapEntry<String, Leg>(k, Leg.fromJson(v))),
        segments: Map.from(json["segments"])
            .map((k, v) => MapEntry<String, Segment>(k, Segment.fromJson(v))),
        places: Map.from(json["places"])
            .map((k, v) => MapEntry<String, FlightPlace>(k, FlightPlace.fromJson(v))),
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
        "alliances": alliances?.toJson(),
      };
}

class Agent {
  String? name;
  String? type;
  String? imageUrl;
  int? feedbackCount;
  double? rating;
  RatingBreakdown? ratingBreakdown;
  bool? isOptimisedForMobile;

  Agent({
    this.name,
    this.type,
    this.imageUrl,
    this.feedbackCount,
    this.rating,
    this.ratingBreakdown,
    this.isOptimisedForMobile,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        name: json["name"],
        type: json["type"],
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
        "type": type,
        "imageUrl": imageUrl,
        "feedbackCount": feedbackCount,
        "rating": rating,
        "ratingBreakdown": ratingBreakdown?.toJson(),
        "isOptimisedForMobile": isOptimisedForMobile,
      };
}

class RatingBreakdown {
  int? customerService;
  int? reliablePrices;
  int? clearExtraFees;
  int? easeOfBooking;
  int? other;

  RatingBreakdown({
    this.customerService,
    this.reliablePrices,
    this.clearExtraFees,
    this.easeOfBooking,
    this.other,
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

class Alliances {
  Alliances();

  factory Alliances.fromJson(Map<String, dynamic> json) => Alliances();

  Map<String, dynamic> toJson() => {};
}

class Carrier {
  String? name;
  String? allianceId;
  String? imageUrl;
  String? iata;
  String? icao;
  String? displayCode;

  Carrier({
    this.name,
    this.allianceId,
    this.imageUrl,
    this.iata,
    this.icao,
    this.displayCode,
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
    this.pricingOptions = const [],
    this.legIds = const [],
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
  Price? price;
  List<String> agentIds;
  List<Item> items;
  String? transferType;
  String? id;
  dynamic pricingOptionFare;

  PricingOption({
    this.price,
    this.agentIds = const [],
    this.items = const [],
    this.transferType,
    this.id,
    this.pricingOptionFare,
  });

  factory PricingOption.fromJson(Map<String, dynamic> json) => PricingOption(
        price: Price.fromJson(json["price"]),
        agentIds: List<String>.from(
            json["agentIds"].map((x) => x)),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        transferType: json["transferType"],
        id: json["id"],
        pricingOptionFare: json["pricingOptionFare"],
      );

  Map<String, dynamic> toJson() => {
        "price": price?.toJson(),
        "agentIds":
            List<dynamic>.from(agentIds.map((x) => x)),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "transferType": transferType,
        "id": id,
        "pricingOptionFare": pricingOptionFare,
      };
}

class Item {
  Price? price;
  String? agentId;
  String? deepLink;
  List<Fare> fares;

  Item({
    this.price,
    this.agentId,
    this.deepLink,
    this.fares = const [],
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        price: Price.fromJson(json["price"]),
        agentId: json["agentId"],
        deepLink: json["deepLink"],
        fares: List<Fare>.from(json["fares"].map((x) => Fare.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "price": price?.toJson(),
        "agentId": agentId,
        "deepLink": deepLink,
        "fares": List<dynamic>.from(fares.map((x) => x.toJson())),
      };
}

class Fare {
  String? segmentId;
  String? bookingCode;
  String? fareBasisCode;

  Fare({
    this.segmentId,
    this.bookingCode,
    this.fareBasisCode,
  });

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
        segmentId: json["segmentId"],
        bookingCode: json["bookingCode"],
        fareBasisCode: json["fareBasisCode"],
      );

  Map<String, dynamic> toJson() => {
        "segmentId": segmentId,
        "bookingCode": bookingCode,
        "fareBasisCode": fareBasisCode,
      };
}

class Price {
  String? amount;
  String? unit;
  String? updateStatus;

  Price({
    this.amount,
    this.unit,
    this.updateStatus,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        amount: json["amount"],
        unit: json["unit"],
        updateStatus: json["updateStatus"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "unit": unit,
        "updateStatus": updateStatus,
      };
}

class Leg {
  String? originPlaceId;
  String? destinationPlaceId;
  DateTimeType? departureDateTime;
  DateTimeType? arrivalDateTime;
  int? durationInMinutes;
  int? stopCount;
  List<String> marketingCarrierIds;
  List<String> operatingCarrierIds;
  List<String> segmentIds;

  Leg({
    this.originPlaceId,
    this.destinationPlaceId,
    this.departureDateTime,
    this.arrivalDateTime,
    this.durationInMinutes,
    this.stopCount,
    this.marketingCarrierIds = const [],
    this.operatingCarrierIds = const [],
    this.segmentIds = const [],
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        originPlaceId: json["originPlaceId"],
        destinationPlaceId: json["destinationPlaceId"],
        departureDateTime: DateTimeType.fromJson(json["departureDateTime"]),
        arrivalDateTime: DateTimeType.fromJson(json["arrivalDateTime"]),
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
        "departureDateTime": departureDateTime?.toJson(),
        "arrivalDateTime": arrivalDateTime?.toJson(),
        "durationInMinutes": durationInMinutes,
        "stopCount": stopCount,
        "marketingCarrierIds":
            List<dynamic>.from(marketingCarrierIds.map((x) => x)),
        "operatingCarrierIds":
            List<dynamic>.from(operatingCarrierIds.map((x) => x)),
        "segmentIds": List<dynamic>.from(segmentIds.map((x) => x)),
      };
}

class DateTimeType {
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;
  int? second;

  DateTimeType({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
  });

  factory DateTimeType.fromJson(Map<String, dynamic> json) => DateTimeType(
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

class FlightPlace {
  String? entityId;
  String? parentId;
  String? name;
  String? type;
  String? iata;
  dynamic coordinates;

  FlightPlace({
    this.entityId,
    this.parentId,
    this.name,
    this.type,
    this.iata,
    this.coordinates,
  });

  factory FlightPlace.fromJson(Map<String, dynamic> json) => FlightPlace(
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
  String? originPlaceId;
  String? destinationPlaceId;
  DateTimeType? departureDateTime;
  DateTimeType? arrivalDateTime;
  int? durationInMinutes;
  String? marketingFlightNumber;
  String? marketingCarrierId;
  String? operatingCarrierId;

  Segment({
    this.originPlaceId,
    this.destinationPlaceId,
    this.departureDateTime,
    this.arrivalDateTime,
    this.durationInMinutes,
    this.marketingFlightNumber,
    this.marketingCarrierId,
    this.operatingCarrierId,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        originPlaceId: json["originPlaceId"],
        destinationPlaceId: json["destinationPlaceId"],
        departureDateTime: DateTimeType.fromJson(json["departureDateTime"]),
        arrivalDateTime: DateTimeType.fromJson(json["arrivalDateTime"]),
        durationInMinutes: json["durationInMinutes"],
        marketingFlightNumber: json["marketingFlightNumber"],
        marketingCarrierId: json["marketingCarrierId"],
        operatingCarrierId: json["operatingCarrierId"],
      );

  Map<String, dynamic> toJson() => {
        "originPlaceId": originPlaceId,
        "destinationPlaceId": destinationPlaceId,
        "departureDateTime": departureDateTime?.toJson(),
        "arrivalDateTime": arrivalDateTime?.toJson(),
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
    this.best = const [],
    this.cheapest = const [],
    this.fastest = const [],
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
  double? score;
  String? itineraryId;

  Est({
    this.score,
    this.itineraryId,
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
  Itineraries? itineraries;

  Stats({
    this.itineraries,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        itineraries: Itineraries.fromJson(json["itineraries"]),
      );

  Map<String, dynamic> toJson() => {
        "itineraries": itineraries?.toJson(),
      };
}

class Itineraries {
  int? minDuration;
  int? maxDuration;
  Total? total;
  Stops? stops;
  bool? hasChangeAirportTransfer;

  Itineraries({
    this.minDuration,
    this.maxDuration,
    this.total,
    this.stops,
    this.hasChangeAirportTransfer,
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
        "total": total?.toJson(),
        "stops": stops?.toJson(),
        "hasChangeAirportTransfer": hasChangeAirportTransfer,
      };
}

class Stops {
  Direct? direct;
  Direct? oneStop;
  Direct? twoPlusStops;

  Stops({
    this.direct,
    this.oneStop,
    this.twoPlusStops,
  });

  factory Stops.fromJson(Map<String, dynamic> json) => Stops(
        direct: Direct.fromJson(json["direct"]),
        oneStop: Direct.fromJson(json["oneStop"]),
        twoPlusStops: Direct.fromJson(json["twoPlusStops"]),
      );

  Map<String, dynamic> toJson() => {
        "direct": direct?.toJson(),
        "oneStop": oneStop?.toJson(),
        "twoPlusStops": twoPlusStops?.toJson(),
      };
}

class Direct {
  Total? total;
  TicketTypes? ticketTypes;

  Direct({
    this.total,
    this.ticketTypes,
  });

  factory Direct.fromJson(Map<String, dynamic> json) => Direct(
        total: Total.fromJson(json["total"]),
        ticketTypes: TicketTypes.fromJson(json["ticketTypes"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total?.toJson(),
        "ticketTypes": ticketTypes?.toJson(),
      };
}

class TicketTypes {
  Total? singleTicket;
  Total? multiTicketNonNpt;
  Total? multiTicketNpt;

  TicketTypes({
    this.singleTicket,
    this.multiTicketNonNpt,
    this.multiTicketNpt,
  });

  factory TicketTypes.fromJson(Map<String, dynamic> json) => TicketTypes(
        singleTicket: Total.fromJson(json["singleTicket"]),
        multiTicketNonNpt: Total.fromJson(json["multiTicketNonNpt"]),
        multiTicketNpt: Total.fromJson(json["multiTicketNpt"]),
      );

  Map<String, dynamic> toJson() => {
        "singleTicket": singleTicket?.toJson(),
        "multiTicketNonNpt": multiTicketNonNpt?.toJson(),
        "multiTicketNpt": multiTicketNpt?.toJson(),
      };
}

class Total {
  int? count;
  Price? minPrice;

  Total({
    this.count,
    this.minPrice,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        count: json["count"],
        minPrice: Price.fromJson(json["minPrice"]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "minPrice": minPrice?.toJson(),
      };
}
