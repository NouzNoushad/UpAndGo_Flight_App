import 'package:flight_booking/core/colors.dart';
import 'package:flight_booking/flight_search/cubit/flight_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/response/flight_initial_data_response.dart';

class FlightDetails extends StatefulWidget {
  final FlightSearchCubit flightSearchCubit;
  final Map<String, dynamic> results;
  final Agent agent;
  const FlightDetails(
      {super.key,
      required this.flightSearchCubit,
      required this.results,
      required this.agent});

  @override
  State<FlightDetails> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  @override
  Widget build(BuildContext context) {
    Price price = widget.results['price'];
    Leg time = widget.results['time'];
    return Scaffold(
      backgroundColor: CustomColors.background1,
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: CustomColors.background2,
      ),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 238, 238, 238),
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'From: ${widget.flightSearchCubit.flightFromController.text}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.backgroundDark2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'To: ${widget.flightSearchCubit.flightToController.text}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.backgroundDark2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat.yMMMd()
                          .format(widget.flightSearchCubit.selectedDate),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.backgroundDark2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Travelers ${widget.flightSearchCubit.travelersTotal}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.backgroundDark2,
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: CustomColors.background1,
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/'
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          // color: Colors.yellow,
                          child:
                              Image.network(widget.agent.imageUrl.toString()),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          widget.agent.name.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.backgroundDark2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            DateFormat.jm().format(DateFormat("hh:mm").parse(
                                '${time.departureDateTime!.hour}:${time.departureDateTime!.minute}')),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.backgroundDark2),
                          ),
                          const Icon(
                            Icons.horizontal_rule,
                            size: 15,
                          ),
                          Text(
                            DateFormat.jm().format(DateFormat("hh:mm").parse(
                                '${time.arrivalDateTime!.hour}:${time.arrivalDateTime!.minute}')),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.backgroundDark2),
                          )
                        ]),
                    Text(
                      '₹${int.parse(price.amount!) / 1000}',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.background3),
                    )
                  ]),
            ),
          ),
          Expanded(
            child: Align(
              child: Container(
                color: CustomColors.background1,
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.background2),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomColors.background1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
