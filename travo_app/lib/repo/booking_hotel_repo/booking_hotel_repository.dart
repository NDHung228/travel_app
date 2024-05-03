import 'package:travo_app/models/booking_hotel_model.dart';

abstract class BookingHotelRepository {
  Future<void> bookingHotel(BookingHotel bookingHotel);
}
