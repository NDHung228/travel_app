import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/pages/booking_flight/one_way_search_flight.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MultiCityScreen extends StatefulWidget {
  const MultiCityScreen({super.key});

  @override
  State<MultiCityScreen> createState() => _MultiCityScreenState();
}

class _MultiCityScreenState extends State<MultiCityScreen> {
  BookingFlight? bookingFlightFrom;
  BookingFlight? bookingFlightTo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          CommonText(
            text: AppLocalizations.of(context)!.flight + " 1",
            fontWeight: FontWeight.w500,
            size: 15,
          ),
          OneWaySearchFlight(
            onBookingFlightChanged: (flight) {
              bookingFlightFrom = flight;
            },
          ),
          CommonText(
            text: AppLocalizations.of(context)!.flight + " 2",
            fontWeight: FontWeight.w500,
            size: 15,
          ),
          OneWaySearchFlight(
            onBookingFlightChanged: (flight) {
              bookingFlightTo = flight; // Update bookingFlight data
            },
          ),
          CommonTextButton(
            text: AppLocalizations.of(context)!.search,
            onPressed: () {},
            buttonWidth: double.infinity,
          ),
          const SizedBox(
            height: 200,
          )
        ]),
      ),
    );
  }
}
