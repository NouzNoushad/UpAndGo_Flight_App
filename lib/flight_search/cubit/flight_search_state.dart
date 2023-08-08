part of 'flight_search_cubit.dart';

@immutable
sealed class FlightSearchState {}

final class FlightSearchInitial extends FlightSearchState {}

final class FlightClassChanged extends FlightSearchState{}

final class SelectFlightDate extends FlightSearchState {}

final class IncreaseTravelerCount extends FlightSearchState{}

final class DecrementTravelerCount extends FlightSearchState{}

final class TotalTravelersState extends FlightSearchState{}