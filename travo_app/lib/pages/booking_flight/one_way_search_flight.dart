import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:intl/intl.dart';
import 'package:country_picker/country_picker.dart';
import 'package:travo_app/models/booking_flight_model.dart';

class OneWaySearchFlight extends StatefulWidget {
  final void Function(BookingFlight)
      onBookingFlightChanged; // Callback function

  const OneWaySearchFlight({Key? key, required this.onBookingFlightChanged})
      : super(key: key);

  @override
  State<OneWaySearchFlight> createState() => _OneWaySearchFlightState();
}

enum TypeClass { Business, Economy }

class _OneWaySearchFlightState extends State<OneWaySearchFlight> {
  final ValueNotifier<DateTime?> selectedDate = ValueNotifier<DateTime?>(null);
  late final ValueNotifier<String?> fromCountry;
  late final ValueNotifier<String?> toCountry;
  late BookingFlight bookingFlight;

  final numberPassenger = ValueNotifier<int>(1);
  late ValueNotifier<List<ValueNotifier<TypeClass>>> typeList;

  @override
  void dispose() {
    selectedDate.dispose();
    fromCountry.dispose();
    toCountry.dispose();
    typeList.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bookingFlight = BookingFlight();
    fromCountry = ValueNotifier('Select country');
    toCountry = ValueNotifier('Select country');
    bookingFlight.from = fromCountry.value;
    bookingFlight.to = toCountry.value;
    typeList = ValueNotifier<List<ValueNotifier<TypeClass>>>(
      List.generate(
        numberPassenger.value,
        (index) => ValueNotifier<TypeClass>(TypeClass.Business),
      ),
    );
    bookingFlight.passengers = numberPassenger.value;
  }

  void updateClassList() {
    typeList.value.add(ValueNotifier<TypeClass>(TypeClass.Business));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('E, d MMM').format(date);
  }

  String extractCountryName(String countryInfo) {
    List<String> parts = countryInfo.split('(');
    return parts[0].trim();
  }

  void saveBookingFlight({bool? redFlad}) {
    bookingFlight.passengerClasses = [];

    for (int i = 0; i < numberPassenger.value; i++) {
      if (i == numberPassenger.value - 1 && redFlad == null) {
        bookingFlight.passengerClasses!.add(TypeClass.Business);
      } else {
        bookingFlight.passengerClasses!.add(typeList.value[i].value);
      }
    }
    widget.onBookingFlightChanged(bookingFlight);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        Stack(
          children: [
            Column(
              children: [
                cardTo(AppLocalizations.of(context)!.to, Icons.location_on),
                const SizedBox(height: 10), // Space between cardTo and cardFrom
                cardFrom(AppLocalizations.of(context)!.from,
                    Icons.airplanemode_active_rounded),
              ],
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 120,
              right: 0,
              child: Center(
                child: iconChangeFromTo(),
              ),
            ),
          ],
        ),
        cardDeparture(AppLocalizations.of(context)!.departure,
            AppLocalizations.of(context)!.select_date, Icons.date_range),
        cardPassengers(AppLocalizations.of(context)!.passengers,
            l10n!.passengers, Icons.person),
        cardClass(AppLocalizations.of(context)!.class_flight, 'Economy',
            Icons.class_, l10n),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }

  Widget cardFrom(String title, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CommonIcon(
                icon: icon,
                color: ColorConstant.primaryColor,
              ),
              Column(
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: ColorConstant.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight:
                            500, // Optional. Country list modal height
                        //Optional. Sets the border radius for the bottomsheet.
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        //Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      onSelect: (Country country) {
                        fromCountry.value =
                            extractCountryName(country.displayName);

                        bookingFlight.from = fromCountry.value;
                        saveBookingFlight();
                      });
                },
                child: ValueListenableBuilder<String?>(
                  valueListenable: fromCountry,
                  builder: (context, value, child) {
                    return CommonText(
                      text: fromCountry.value!,
                      fontWeight: FontWeight.w500,
                      size: 15,
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cardTo(String title, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: ColorConstant.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              CommonIcon(
                icon: icon,
                color: ColorConstant.coralColor,
                size: 20,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight:
                            500, // Optional. Country list modal height
                        //Optional. Sets the border radius for the bottomsheet.
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        //Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      onSelect: (Country country) {
                        toCountry.value =
                            extractCountryName(country.displayName);
                      });
                  bookingFlight.to = toCountry.value;
                  saveBookingFlight();
                },
                child: ValueListenableBuilder<String?>(
                  valueListenable: toCountry,
                  builder: (context, value, child) {
                    return CommonText(
                      text: toCountry.value!,
                      fontWeight: FontWeight.w500,
                      size: 15,
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cardDeparture(String title, String content, IconData icon) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: ColorConstant.coralColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: ColorConstant.coralColor,
            size: 20,
          ),
        ),
        title: Text(title),
        subtitle: InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: ValueListenableBuilder<DateTime?>(
            valueListenable: selectedDate,
            builder: (context, value, child) {
              String formattedDate =
                  value != null ? formatDate(value) : content;
              bookingFlight.dateStart = formattedDate;
              saveBookingFlight();
              return Text(
                formattedDate,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget cardPassengers(String title, String content, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: ColorConstant.coralColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: ColorConstant.coralColor,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              Row(
                children: [
                  CommonText(
                    text: content,
                    fontWeight: FontWeight.w500,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    onTap: () {
                      if (numberPassenger.value > 1) {
                        numberPassenger.value = numberPassenger.value - 1;
                        bookingFlight.passengers = numberPassenger.value;
                        saveBookingFlight();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: ColorConstant
                                .primaryColor), // Add outline color here
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: ColorConstant.primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: numberPassenger,
                    builder: (context, value, child) {
                      return CommonText(text: numberPassenger.value.toString());
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      numberPassenger.value = numberPassenger.value + 1;
                      bookingFlight.passengers = numberPassenger.value;
                      saveBookingFlight();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: ColorConstant
                                .primaryColor), // Add outline color here
                      ),
                      child: const Icon(
                        Icons.add,
                        color: ColorConstant.primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget iconChangeFromTo() {
    return GestureDetector(
      onTap: () {
        var temp = toCountry.value;
        toCountry.value = fromCountry.value;
        fromCountry.value = temp;
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstant.lavenderColor,
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.arrow_upward,
                  color: ColorConstant.blackColor, size: 24),
              Icon(Icons.arrow_downward,
                  color: ColorConstant.blackColor, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardOption(AppLocalizations ln10, int index) {
    updateClassList(); // Call the function here

    return SizedBox(
      height: 150,
      width: double.maxFinite,
      child: ValueListenableBuilder<List<ValueNotifier<TypeClass>>>(
        valueListenable: typeList,
        builder: (context, selectedClasses, child) {
          return Column(
            children: <Widget>[
              CommonText(
                text: '${ln10.passengers} ${index + 1}',
                fontWeight: FontWeight.w500,
              ),
              ListTile(
                title: Text(ln10.business_class),
                leading: ValueListenableBuilder<TypeClass>(
                  valueListenable: selectedClasses[index],
                  builder: (context, selectedClass, child) {
                    return Radio<TypeClass>(
                      value: TypeClass.Business,
                      groupValue: selectedClass,
                      onChanged: (TypeClass? value) {
                        selectedClasses[index].value = TypeClass.Business;
                        saveBookingFlight(redFlad: true);
                      },
                    );
                  },
                ),
              ),
              ListTile(
                title: Text(ln10.economy_class),
                leading: ValueListenableBuilder<TypeClass>(
                  valueListenable: selectedClasses[index],
                  builder: (context, selectedClass, child) {
                    return Radio<TypeClass>(
                      value: TypeClass.Economy,
                      groupValue: selectedClass,
                      onChanged: (TypeClass? value) {
                        selectedClasses[index].value = TypeClass.Economy;
                        saveBookingFlight(redFlad: true);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget cardClass(
      String title, String content, IconData icon, AppLocalizations ln10) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorConstant.tealColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  icon,
                  color: ColorConstant.tealColor,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ValueListenableBuilder(
            valueListenable: numberPassenger,
            builder: (context, value, child) {
              return Column(
                children: [
                  for (int i = 0; i < numberPassenger.value; i++)
                    cardOption(ln10, i)
                ],
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
