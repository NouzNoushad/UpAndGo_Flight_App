import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flight_booking/core/constant.dart';
import 'package:flight_booking/flight_search/service/flight_search_service.dart';
import 'package:flutter/material.dart';

import '../../model/response/auto_suggest_response.dart';

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
    AutoSuggestResponse suggestResponse =
        await flightSearchService.autoSuggestFlight(searchTerm);
    autoSuggestSink.add(suggestResponse.places);
    print('/////// suggestion: ${suggestResponse.places}');
  }

  String flightCode(String hierarchy) {
    List<String> splitText = hierarchy.split(',');
    String flightCode = splitText.first;
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
      }
    }
    if (travelerState == TravelerState.infants) {
      if (infants >= 1) {
        return;
      } else {
        infants = infants + 1;
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
      }
    }
    if (travelerState == TravelerState.infants) {
      if (infants <= 0) {
        return;
      } else {
        infants = infants - 1;
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

  // initiateFlightPrice() async {
  //   await flightSearchService.initiateFlightPrice(
  //       originIata: originIata,
  //       destinationIata: destinationIata,
  //       year: year,
  //       month: month,
  //       day: day,
  //       adults: adults,
  //       childrenAges: childrenAges,
  //       cabinClass: cabinClass);
  // }
}
