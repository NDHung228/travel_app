import 'package:flutter/material.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/booking_hotel_appbar.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/payment_body.dart';
import 'package:travo_app/provider/booking_hotel_provider.dart';

class PaymentScreen extends StatelessWidget {
  final BookingHotel? bookingHotel;

  const PaymentScreen({Key? key, this.bookingHotel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BookingHotelProvider(
      bookingHotel: bookingHotel!,
      child: const Scaffold(
        body: Stack(
          children: [
            BookingHotelAppBar(
              index: 2,
            ),
            PaymentBody()
          ],
        ),
      ),
    );
  }
}
