import 'package:flight_booking/core/colors.dart';
import 'package:flight_booking/core/constant.dart';
import 'package:flight_booking/flight_search/cubit/flight_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

travelersDetailsBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: CustomColors.background1,
      builder: (c) => BlocProvider.value(
            value: BlocProvider.of<FlightSearchCubit>(context),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<FlightSearchCubit, FlightSearchState>(
                builder: (context, state) {
                  FlightSearchCubit flightSearchCubit =
                      BlocProvider.of<FlightSearchCubit>(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Travelers',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.backgroundDark2,
                        ),
                      ),
                      const Spacer(),
                      TravelerTile(
                        title: 'Adults',
                        subtitle: '12+ years',
                        traveler: flightSearchCubit.adults,
                        onPressedAdd: () {
                          flightSearchCubit.increaseCount(TravelerState.adults);
                        },
                        onPressedRemove: () {
                          flightSearchCubit
                              .decrementCount(TravelerState.adults);
                        },
                      ),
                      TravelerTile(
                        title: 'Children',
                        subtitle: '2-12 years',
                        traveler: flightSearchCubit.children,
                        onPressedAdd: () {
                          flightSearchCubit
                              .increaseCount(TravelerState.children);
                        },
                        onPressedRemove: () {
                          flightSearchCubit
                              .decrementCount(TravelerState.children);
                        },
                      ),
                      TravelerTile(
                        title: 'Infants',
                        subtitle: 'Under 2 years',
                        traveler: flightSearchCubit.infants,
                        onPressedAdd: () {
                          flightSearchCubit
                              .increaseCount(TravelerState.infants);
                        },
                        onPressedRemove: () {
                          flightSearchCubit
                              .decrementCount(TravelerState.infants);
                        },
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              flightSearchCubit.findTotalTravelers();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.background2,
                            ),
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )),
                      ),
                    ],
                  );
                },
              ),
            ),
          ));
}

class TravelerTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int traveler;
  final Color buttonColor;
  final void Function()? onPressedRemove;
  final void Function()? onPressedAdd;
  const TravelerTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.traveler,
      this.buttonColor = CustomColors.background2,
      this.onPressedRemove,
      this.onPressedAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  color: CustomColors.backgroundDark2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: CustomColors.background2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                  onPressed: onPressedRemove,
                  icon: const Icon(
                    Icons.remove,
                    color: CustomColors.background1,
                  )),
            ),
            Expanded(
                child: Center(
                    child: Text(
              '$traveler',
              style: const TextStyle(
                fontSize: 18,
                color: CustomColors.backgroundDark2,
              ),
            ))),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                  onPressed: onPressedAdd,
                  icon: const Icon(
                    Icons.add,
                    color: CustomColors.background1,
                  )),
            ),
          ]),
        ),
      ]),
    );
  }
}
