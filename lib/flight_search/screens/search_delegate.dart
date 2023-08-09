import 'package:flight_booking/core/constant.dart';
import 'package:flight_booking/flight_search/cubit/flight_search_cubit.dart';
import 'package:flight_booking/model/response/auto_suggest_response.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';

class FlightSearchDelegate extends SearchDelegate {
  final FlightSearchCubit flightSearchCubit;
  final TextFieldType textFieldType;
  FlightSearchDelegate(
      {required this.flightSearchCubit, required this.textFieldType});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: CustomColors.background1,
      ),
      hintColor: CustomColors.background2,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: CustomColors.background2,
      ),
      inputDecorationTheme:
          const InputDecorationTheme(focusedBorder: InputBorder.none),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: CustomColors.background2,
          decorationThickness: 0.0000001,
        ),
      ),
    );
  }

  @override
  String? get searchFieldLabel => 'Search Flight';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(
          Icons.close,
          size: 20,
          color: CustomColors.background2,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back,
        size: 20,
        color: CustomColors.background2,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    flightSearchCubit.autoSuggestFlight(query);
    return suggestionList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // var flightSearchCubit =
    //     BlocProvider.of<FlightSearchCubit>(context);
    // flightSearchCubit.autoSuggestFlight(query);
    return suggestionList();
  }

  Widget suggestionList() {
    return Material(
      color: CustomColors.background1,
      child: StreamBuilder(
          stream: flightSearchCubit.autoSuggestStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(color: CustomColors.background2),
                ),
              );
            }
            if (snapshot.data.length <= 0) {
              return const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(color: CustomColors.background2),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                Place flight = snapshot.data[index];
                return GestureDetector(
                  onTap: () {
                    textFieldType == TextFieldType.from
                        ? flightSearchCubit.flightFromController.text =
                            flightSearchCubit.flightCode(flight, textFieldType)
                        : flightSearchCubit.flightToController.text =
                            flightSearchCubit.flightCode(flight, textFieldType);
                    Navigator.pop(context);
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flightSearchCubit.flightCode(flight, textFieldType),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.backgroundDark2,
                            ),
                          ),
                          Text(
                            flightSearchCubit.flightCountry(flight.hierarchy),
                            style: const TextStyle(
                              fontSize: 14,
                              color: CustomColors.background2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
