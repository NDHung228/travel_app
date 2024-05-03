import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:travo_app/blocs/booking_hotel_bloc/booking_hotel_bloc.dart';
import 'package:travo_app/blocs/room_bloc/room_bloc.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/booking_hotel_appbar.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/confirm_booking_body.dart';
import 'package:travo_app/provider/booking_hotel_provider.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';

class ConFirmBookingRoom extends StatelessWidget {
  final BookingHotel? bookingHotel;

  const ConFirmBookingRoom({Key? key, this.bookingHotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCases userRepository = AuthCases();
    return BookingHotelProvider(
      bookingHotel: bookingHotel!,
      child: Scaffold(
        body: Stack(
          children: [
            const BookingHotelAppBar(
              index: 3,
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => RoomBloc(),
                ),
                BlocProvider(
                  create: (context) => BookingHotelBloc(),
                ),
                BlocProvider(
                  create: (context) =>
                      AuthenticationBloc(userRepository: userRepository),
                ),
              ],
              child: ConfirmBookingBody(
                bookingHotel: bookingHotel!,
              ),
            )
          ],
        ),
      ),
    );
  }
}
