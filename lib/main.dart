import 'package:flight_booking/flight_search/cubit/flight_search_cubit.dart';
import 'package:flight_booking/flight_search/screens/flight_search.dart';
import 'package:flight_booking/flight_search/service/flight_search_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/colors.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CustomColors.primarySwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => FlightSearchCubit(
          flightSearchService: FlightSearchService()
        ),
        child: const FlightSearch(),
      ),
    );
  }
}
