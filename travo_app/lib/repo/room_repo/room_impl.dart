import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travo_app/constant/utils/collection_constant.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/repo/room_repo/room_repo.dart';

class RoomImplement extends RoomRepository {
  @override
  Future<List<Room>> getRooms(String hotelId) async {
    List<Room> roomList = [];

    try {
      final rooms = await FirebaseFirestore.instance
          .collection(CollectionConstant.ROOM_COLLECTION)
          .where('hotel', isEqualTo: hotelId)
          .get();
      rooms.docs.forEach((element) {
        var room = Room.fromJson(element.data()).copyWith(roomId: element.id);
        return roomList.add(room);
      });

      for (int i = 0; i < roomList.length; i++) {
        for (int j = 0; j < roomList[i].services.length; j++) {
          var service = await FirebaseFirestore.instance
              .collection(CollectionConstant.SERVICE_COLLECTION)
              .doc(roomList[i].services[j])
              .get();
          if (service.exists) {
            roomList[i].services[j] = service.get('name');
          }
        }
      }

      return roomList;
    } on FirebaseException catch (e) {
      print(e);
      return roomList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Room> getRoomById(String roomId) async {
    try {
      final roomDoc = await FirebaseFirestore.instance
          .collection(CollectionConstant.ROOM_COLLECTION)
          .doc(roomId)
          .get();
      if (roomDoc.exists) {
        var room = Room.fromJson(roomDoc.data()!);
        return room.copyWith(roomId: roomDoc.id);
      } else {
        throw Exception("Room not found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<BookingHotel>> getListBookingHotel(String email) async {
    List<BookingHotel> bookingList = [];

    try {
      final bookingSnapshot = await FirebaseFirestore.instance
          .collection(CollectionConstant.BOOKING_COLLECTION)
          .where('email', isEqualTo: email)
          .get();

      if (bookingSnapshot.docs.isNotEmpty) {
        bookingList = bookingSnapshot.docs
            .map((doc) => BookingHotel.fromJson(
                doc.data() as Map<String, dynamic>? ?? {}))
            .toList();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    
    return bookingList;
  }
}
