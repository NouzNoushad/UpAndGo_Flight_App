import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flight_booking/core/constant.dart';
import 'package:flight_booking/flight_search/service/flight_search_service.dart';
import 'package:flutter/material.dart';

import '../../model/response/auto_suggest_response.dart';
import '../../model/response/flight_initial_data_response.dart';

part 'flight_search_state.dart';

class FlightSearchCubit extends Cubit<FlightSearchState> {
  final FlightSearchService flightSearchService;
  FlightSearchCubit({
    required this.flightSearchService,
  }) : super(FlightSearchInitial());

  TextEditingController flightFromController = TextEditingController();
  TextEditingController flightToController = TextEditingController();
  FocusNode flightFromFocusNode = FocusNode();
  FocusNode flightToFocusNode = FocusNode();

  StreamController autoSuggestController = StreamController.broadcast();
  StreamSink get autoSuggestSink => autoSuggestController.sink;
  Stream get autoSuggestStream => autoSuggestController.stream;

  String selectedClass = flightClass.first;
  DateTime selectedDate = DateTime.now();
  List<int> childrenAges = [];
  List agentsList = [];
  String fromIata = '';
  String toIata = '';
  int travelersTotal = 1;
  int adults = 1;
  int children = 0;
  int infants = 0;

  flightClassChanged(value) {
    selectedClass = value;
    emit(FlightClassChanged());
  }

  selectFlightDate(value) {
    selectedDate = value;
    emit(SelectFlightDate());
  }

  autoSuggestFlight(String searchTerm) async {
    AutoSuggestResponse? suggestResponse =
        await flightSearchService.autoSuggestFlight(searchTerm);
    if (suggestResponse != null) {
      autoSuggestSink.add(suggestResponse.places);
      print('/////// suggestion: ${suggestResponse.places}');
    }
  }

  String flightCode(Place place, TextFieldType textFieldType) {
    List<String> splitText = place.hierarchy.split(',');
    String flightCode = splitText.first;
    if (textFieldType == TextFieldType.from) {
      if (place.iataCode != null) {
        fromIata = place.iataCode!;
      }
    }
    if (textFieldType == TextFieldType.to) {
      if (place.iataCode != null) {
        toIata = place.iataCode!;
      }
    }
    return flightCode;
  }

  String flightCountry(String hierarchy) {
    List<String> splitText = hierarchy.split(',');
    String country = splitText.last.split('|').last;
    return country;
  }

  increaseCount(TravelerState travelerState) {
    if (travelerState == TravelerState.adults) {
      if (adults >= 8) {
        return;
      } else {
        adults = adults + 1;
      }
    }
    if (travelerState == TravelerState.children) {
      if (children >= 7) {
        return;
      } else {
        children = children + 1;
        childrenAges.add(5);
      }
    }
    if (travelerState == TravelerState.infants) {
      if (infants >= 1) {
        return;
      } else {
        infants = infants + 1;
        childrenAges.add(1);
      }
    }
    emit(IncreaseTravelerCount());
  }

  decrementCount(TravelerState travelerState) {
    if (travelerState == TravelerState.adults) {
      if (adults <= 1) {
        return;
      } else {
        adults = adults - 1;
      }
    }
    if (travelerState == TravelerState.children) {
      if (children <= 0) {
        return;
      } else {
        children = children - 1;
        childrenAges.remove(5);
      }
    }
    if (travelerState == TravelerState.infants) {
      if (infants <= 0) {
        return;
      } else {
        infants = infants - 1;
        childrenAges.remove(1);
      }
    }
    emit(IncreaseTravelerCount());
  }

  findTotalTravelers() {
    travelersTotal = adults + children + infants;
    emit(TotalTravelersState());
  }

  flightTextValidator(String value) {
    if (value.isEmpty) {
      return 'Fields should not be empty';
    }
  }

  Future<List<Map<String, dynamic>>> initiateFlightPrice() async {
    List<Map<String, dynamic>> flightList = [];
    int day = selectedDate.day;
    int year = selectedDate.year;
    int month = selectedDate.month;
    String cabinClass =
        'CABIN_CLASS_${selectedClass.toUpperCase().replaceAll(' ', '_')}';
    String originIata = fromIata;
    String destinationIata = toIata;
    if (originIata == '' || destinationIata == '') {
      print('/////////// empty iata');
    } else {
      print('/////////// children Ages: $childrenAges');
      print('/////////// date: $day, $month, $year');
      print('/////////// cabin: $cabinClass');
      print('/////////// origin: $originIata');
      print('/////////// dest: $destinationIata');
      print('/////////// adults: $adults');

      FlightInitialDataResponse? response =
          await flightSearchService.initiateFlightPrice(
              originIata: originIata,
              destinationIata: destinationIata,
              year: year,
              month: month,
              day: day,
              adults: adults,
              childrenAges: childrenAges,
              cabinClass: cabinClass);
      if (response != null) {
        FlightInitialDataResponse? fullFlightResponse =
            await flightSearchService.fullFlightPrice(
                sessionToken: response.sessionToken);
        if (fullFlightResponse != null) {
          // fullFlightSink.add(fullFlightResponse.content.results);
          Map<String, Itinerary>? it =
              fullFlightResponse.content.results?.itineraries;
          var lg = fullFlightResponse.content.results?.legs;
          var ag = fullFlightResponse.content.results?.agents;
          // debugPrint('//////////////// Price: $it');
          // debugPrint('//////////////// Time: $lg');
          // debugPrint('//////////////// Name: $ag');

          List<List<PricingOption>> priceOptions =
              it!.values.map((e) => e.pricingOptions).toList();
          List<Leg> legs = lg!.values.map((e) => e).toList();
          List agents = [];
          for (var i = 0; i < priceOptions.length; i++) {
            var prices = priceOptions[i].map((e) {
              for (var element in ag!.keys) {
                // print('///// element: $element');
                // print(
                //     '//////// agentId:${e.agentIds[0]}, ${e.agentIds[0].contains(element)}');
                if (e.agentIds[0].contains(element)) {
                  int index = ag.keys.toList().indexOf(element);
                  var agent = ag.values.toList()[index];
                  agents.add(agent);
                  print('//////////// agentMid, ${agents.length}');
                }
              }
              return {
                'price': e.price,
                'agentId': e.agentIds[0],
                'time': legs[i]
              };
            }).toList();
            flightList += [...prices];
          }
          agentsList += [...agents];
          print('//////////// agents, ${agentsList.length}');
        }
      }
      // clear all flight data
      // flightFromController.text = '';
      // flightToController.text = '';
      // selectedDate = DateTime.now();
      // adults = 1;
      // childrenAges = [];
      // selectedClass = flightClass.first;
    }
    print('////////////////// flight list: ${flightList.length}');
    return flightList;
  }
}
