import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/book_and_review.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/booking_hotel_appbar.dart';

class BookingHotelScreen extends StatelessWidget {
  final Room room;
  const BookingHotelScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BookingHotelAppBar(index: 1,),
          BookAndReview(room: room)
        ],
      ),
    );
  }
}
