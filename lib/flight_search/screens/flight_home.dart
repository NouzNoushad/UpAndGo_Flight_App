import 'package:flight_booking/core/colors.dart';
import 'package:flight_booking/flight_search/cubit/flight_search_cubit.dart';
import 'package:flight_booking/flight_search/screens/flight_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/response/flight_initial_data_response.dart';

class FlightHome extends StatefulWidget {
  final FlightSearchCubit flightSearchCubit;
  const FlightHome({super.key, required this.flightSearchCubit});

  @override
  State<FlightHome> createState() => _FlightHomeState();
}

class _FlightHomeState extends State<FlightHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background4,
      appBar: AppBar(
        title: Text(
            '${widget.flightSearchCubit.flightFromController.text} - ${widget.flightSearchCubit.flightToController.text}'),
        backgroundColor: CustomColors.background2,
        titleTextStyle: const TextStyle(
          fontSize: 15,
          color: CustomColors.background1,
        ),
      ),
      body: FutureBuilder(
          future: widget.flightSearchCubit.initiateFlightPrice(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> results = snapshot.data![index];
                    Agent agent = widget.flightSearchCubit.agentsList[index];
                    Price price = results['price'];
                    Leg time = results['time'];
                    String agentId = results['agentId'];
                    print('/////////////// results: $agentId');
                    print('/////////////// results: ${agent.name}');
                    return Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          print('tapped');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FlightDetails(
                                  flightSearchCubit: widget.flightSearchCubit,
                                  results: results,
                                  agent: agent)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.background1,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Row(children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  // color: CustomColors.background2,
                                  child:
                                      Image.network(agent.imageUrl.toString()),
                                ),
                              ],
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          DateFormat.jm().format(
                                              DateFormat("hh:mm").parse(
                                                  '${time.departureDateTime!.hour}:${time.departureDateTime!.minute}')),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  CustomColors.backgroundDark2),
                                        ),
                                        const Icon(
                                          Icons.horizontal_rule,
                                          size: 15,
                                        ),
                                        Text(
                                          DateFormat.jm().format(
                                              DateFormat("hh:mm").parse(
                                                  '${time.arrivalDateTime!.hour}:${time.arrivalDateTime!.minute}')),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  CustomColors.backgroundDark2),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    agent.name.toString(),
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      color: CustomColors.background2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '₹${int.parse(price.amount!) / 1000}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: CustomColors.background3),
                                  )),
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text(
                  'Empty Flights',
                  style: TextStyle(color: CustomColors.backgroundDark2),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
