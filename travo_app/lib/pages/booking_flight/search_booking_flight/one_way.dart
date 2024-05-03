import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import 'package:travo_app/common_widgets/common_text_button_widget.dart';

import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/pages/booking_flight/one_way_search_flight.dart';
import 'package:travo_app/routes/route_name.dart';

class OneWayScreen extends StatefulWidget {
  const OneWayScreen({Key? key}) : super(key: key);

  @override
  State<OneWayScreen> createState() => _OneWayScreenState();
}

class _OneWayScreenState extends State<OneWayScreen> {
  BookingFlight? bookingFlight;

  void updateBookingFlight(BookingFlight flight) {
    bookingFlight = flight;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          children: [
            OneWaySearchFlight(
              onBookingFlightChanged: updateBookingFlight,
            ),
            CommonTextButton(
              text: AppLocalizations.of(context)!.search,
              onPressed: () {
                print('demo booking flight ${bookingFlight!.passengerClasses}');
                if (bookingFlight != null) {
                  context.push(RoutName.searchResultFlightRouteName,
                      extra: bookingFlight);
              }
              },
              buttonWidth: double.infinity,
            ),
          ],
        ),
      
    );
  }
}
