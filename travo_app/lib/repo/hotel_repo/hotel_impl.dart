import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travo_app/constant/utils/collection_constant.dart';
import 'package:travo_app/models/hotel.model.dart';
import 'package:travo_app/repo/hotel_repo/hotel_repository.dart';

class HotelImplement implements HotelRepository {
  @override
  Future<List<Hotel>> getHotels() async {
    List<Hotel> hotelList = [];
    try {
      final hotels = await FirebaseFirestore.instance
          .collection(CollectionConstant.HOTEL_COLLECTION)
          .get();

      hotels.docs.forEach((element) {
        Hotel hotel =
            Hotel.fromJson(element.data()).copyWith(hotelId: element.id);
        return hotelList.add(hotel);
      });
      return hotelList;
    } on FirebaseException catch (e) {
      print(e);
      return hotelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Hotel>> searchHotels(String keyword) async {
    List<Hotel> hotelList = [];
    try {
      final hotels = await FirebaseFirestore.instance
          .collection(CollectionConstant.HOTEL_COLLECTION)
          .get();

      hotels.docs.forEach((element) {
        Hotel hotel =
            Hotel.fromJson(element.data()).copyWith(hotelId: element.id);
        if (hotel.name.toLowerCase().contains(keyword.toLowerCase())) {
          hotelList.add(hotel);
        }
      });
      return hotelList;
    } on FirebaseException catch (e) {
      print(e);
      return hotelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Hotel>> filterHotels(String? keyword, double? startPrice,
      double? endPrice, String? sort) async {
    List<Hotel> hotelList = [];
    try {
      final hotels = await FirebaseFirestore.instance
          .collection(CollectionConstant.HOTEL_COLLECTION)
          .get();

      hotels.docs.forEach((element) {
        Hotel hotel =
            Hotel.fromJson(element.data()).copyWith(hotelId: element.id);

        if ((keyword == null ||
                hotel.name.toLowerCase().contains(keyword.toLowerCase())) &&
            (startPrice == null || hotel.price >= startPrice) &&
            (endPrice == null || hotel.price <= endPrice)) {
          hotelList.add(hotel);
        }
      });
      // sort hotel
      if (sort != null && sort.isNotEmpty) {
        if (sort == 'Lowest Price') {
          hotelList.sort((a, b) => a.price.compareTo(b.price));
        } else if (sort == 'Highest Price') {
          hotelList.sort((a, b) => b.price.compareTo(a.price));
        } else if (sort == 'Highest Rating') {
          hotelList.sort((a, b) => b.rating.compareTo(a.rating));
        } else if (sort == 'Highest Popularity') {
          hotelList.sort((a, b) => b.total_review.compareTo(a.total_review));
        }
      }
      return hotelList;
    } on FirebaseException catch (e) {
      print(e);
      return hotelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

 
}
