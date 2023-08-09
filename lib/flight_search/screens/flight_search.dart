import 'package:flight_booking/core/colors.dart';
import 'package:flight_booking/core/constant.dart';
import 'package:flight_booking/flight_search/screens/flight_home.dart';
import 'package:flight_booking/flight_search/cubit/flight_search_cubit.dart';
import 'package:flight_booking/flight_search/screens/search_delegate.dart';
import 'package:flight_booking/flight_search/screens/travelers_details.dart';
import 'package:flight_booking/utils/flight_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FlightSearch extends StatefulWidget {
  const FlightSearch({super.key});

  @override
  State<FlightSearch> createState() => _FlightSearchState();
}

class _FlightSearchState extends State<FlightSearch> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.background2,
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColors.background1,
                ),
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<FlightSearchCubit, FlightSearchState>(
                  builder: (context, state) {
                    FlightSearchCubit flightSearchCubit =
                        BlocProvider.of<FlightSearchCubit>(context);
                    return Form(
                      key: formKey,
                      child: Column(children: [
                        const Spacer(),
                        FlightTextField(
                          icon: Icons.flight_takeoff,
                          controller: flightSearchCubit.flightFromController,
                          hintText: 'From',
                          focusNode: flightSearchCubit.flightFromFocusNode,
                          validator: (value) =>
                              flightSearchCubit.flightTextValidator(value!),
                          onTapOutside: (value) {
                            flightSearchCubit.flightFromFocusNode.unfocus();
                          },
                          onTap: () {
                            flightSearchCubit.flightFromController.text = '';
                            print('From.........');
                            showSearch(
                                context: context,
                                delegate: FlightSearchDelegate(
                                  flightSearchCubit: flightSearchCubit,
                                  textFieldType: TextFieldType.from,
                                ));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FlightTextField(
                          controller: flightSearchCubit.flightToController,
                          icon: Icons.flight_land,
                          hintText: 'To',
                          focusNode: flightSearchCubit.flightToFocusNode,
                          validator: (value) =>
                              flightSearchCubit.flightTextValidator(value!),
                          onTapOutside: (value) {
                            flightSearchCubit.flightToFocusNode.unfocus();
                          },
                          onTap: () {
                            print('To........');
                            flightSearchCubit.flightToController.text = '';
                            showSearch(
                                context: context,
                                delegate: FlightSearchDelegate(
                                  flightSearchCubit: flightSearchCubit,
                                  textFieldType: TextFieldType.to,
                                ));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: size.height * 0.09,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1.5, color: CustomColors.background2),
                          ),
                          child: Row(children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate:
                                          flightSearchCubit.selectedDate,
                                      firstDate: DateTime(1990),
                                      lastDate: DateTime(2100),
                                      builder: (context, child) => Theme(
                                          data: ThemeData.light().copyWith(
                                            primaryColor:
                                                CustomColors.background2,
                                            colorScheme:
                                                const ColorScheme.light(
                                                    primary: CustomColors
                                                        .background2),
                                            buttonTheme: const ButtonThemeData(
                                                textTheme:
                                                    ButtonTextTheme.primary),
                                          ),
                                          child: child!)).then((value) {
                                    if (value == null) {
                                      return;
                                    }
                                    flightSearchCubit.selectFlightDate(value);
                                    print(
                                        '/////////// picked date: ${flightSearchCubit.selectedDate}');
                                  });
                                },
                                icon: const Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                ),
                                color: CustomColors.background2,
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Text(
                                DateFormat.yMMMd()
                                    .format(flightSearchCubit.selectedDate),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.backgroundDark2),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    travelersDetailsBottomSheet(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: CustomColors.background2,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Travelers ${flightSearchCubit.travelersTotal}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.background1),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: CustomColors.background2,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.center,
                                  child: DropdownButton(
                                    underline: Container(),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: CustomColors.background1,
                                    ),
                                    isExpanded: false,
                                    value: flightSearchCubit.selectedClass,
                                    dropdownColor: CustomColors.background2,
                                    borderRadius: BorderRadius.circular(20),
                                    items: flightClass
                                        .map((code) => DropdownMenuItem(
                                            value: code,
                                            child: Center(
                                                child: Text(
                                              code,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      CustomColors.background1),
                                            ))))
                                        .toList(),
                                    onChanged: (value) => flightSearchCubit
                                        .flightClassChanged(value!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                              onTap: () async {
                                var navigator = Navigator.of(context);
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  await flightSearchCubit.initiateFlightPrice();
                                  navigator.push(MaterialPageRoute(
                                      builder: (context) => FlightHome(
                                            flightSearchCubit:
                                                flightSearchCubit,
                                          )));
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.background3,
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Search',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.background1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.search,
                                      size: 20,
                                      color: CustomColors.background1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
