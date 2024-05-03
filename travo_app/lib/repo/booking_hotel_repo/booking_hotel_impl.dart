import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travo_app/constant/utils/collection_constant.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/repo/booking_hotel_repo/booking_hotel_repository.dart';

class BookingHotelImplement implements BookingHotelRepository {
  final bookingCollection = FirebaseFirestore.instance
      .collection(CollectionConstant.BOOKING_COLLECTION);

  @override
  Future<void> bookingHotel(BookingHotel bookingHotel) async {
    try {
      Map<String, dynamic> bookingData = bookingHotel.toJson();

      DocumentReference docRef = await bookingCollection.add(bookingData);
      String documentId = docRef.id;
      print('demo document added with ID: $documentId');
    
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}

