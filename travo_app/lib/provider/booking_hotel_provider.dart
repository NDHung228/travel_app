import 'package:flutter/material.dart';
import 'package:travo_app/models/booking_hotel_model.dart';

class BookingHotelProvider extends InheritedWidget {
  final BookingHotel bookingHotel;

  BookingHotelProvider({
    required this.bookingHotel,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static BookingHotelProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BookingHotelProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
