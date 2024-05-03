import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/models/room_model.dart';

abstract class RoomRepository {
  Future<List<Room>> getRooms(String hotelId);

  Future<Room> getRoomById(String roomId);

  Future<List<BookingHotel>> getListBookingHotel(String email);
}
