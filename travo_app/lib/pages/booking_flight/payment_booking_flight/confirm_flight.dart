import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/booking_flight_bloc/booking_flight_bloc.dart';

import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/pages/booking_flight/payment_booking_flight/booking_flight_components/body_confirm_flight.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/booking_hotel_appbar.dart';

class ConfirmFlight extends StatelessWidget {
  final BookingFlight bookingFlight;
  const ConfirmFlight({super.key, required this.bookingFlight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BookingHotelAppBar(
              index: 3,
            ),
            BlocProvider(
              create: (context) => BookingFlightBloc(),
              child: BodyConfirmFlight(bookingFlight: bookingFlight),
            )
          ],
        ),
      ),
    );
  }
}
