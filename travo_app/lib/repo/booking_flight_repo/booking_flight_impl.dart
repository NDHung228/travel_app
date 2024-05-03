import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travo_app/constant/utils/collection_constant.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/flight_model.dart';
import 'package:travo_app/models/search_flight_model.dart';
import 'package:travo_app/repo/booking_flight_repo/booking_flight_repository.dart';

class BookingFlightImplement implements BookingFlightRepository {
  @override
  Future<void> bookingFlight(BookingFlight bookingFlight) async {
    try {
      final bookingCollection = FirebaseFirestore.instance
          .collection(CollectionConstant.BOOKING_FLIGHT_COLLECTION);
      Map<String, dynamic> bookingData = bookingFlight.toJson();

      DocumentReference docRef = await bookingCollection.add(bookingData);
      String documentId = docRef.id;
      print('demo document added with ID: $documentId');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Flight>> getListFlight() async {
    List<Flight> flightList = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> flightsSnapshot =
          await FirebaseFirestore.instance
              .collection(CollectionConstant
                  .FLIGHT_COLLECTION) // Update with your collection name
              .get();

      flightsSnapshot.docs.forEach((element) {
        Flight flight = Flight.fromMap(element.data());

        return flightList.add(flight);
      });
      return flightList;
    } on FirebaseException catch (e) {
      print(e);
      return flightList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Flight>> searchListFlight(SearchFlightModel searchFlight) async {
    List<Flight> flightList = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> flightsSnapshot =
          await FirebaseFirestore.instance
              .collection(CollectionConstant
                  .FLIGHT_COLLECTION) // Update with your collection name
              .get();

      flightsSnapshot.docs.forEach((element) {
        Flight flight = Flight.fromMap(element.data());
        int hourFlight = flight.departureTime.hour - flight.arriveTime.hour;

        if (searchFlight.startPrice! <= flight.price &&
            searchFlight.endPrice! >= flight.price &&
            searchFlight.startTime! <= hourFlight &&
            searchFlight.endTime! >= hourFlight) {
          flightList.add(flight);
        }
      });

      if (searchFlight.sort != null &&
          searchFlight.sort == 'Earliest Departure') {
        flightList.sort((a, b) => a.departureTime.compareTo(b.departureTime));
      } else if (searchFlight.sort != null &&
          searchFlight.sort == 'Latest Departure') {
        flightList.sort((a, b) => b.departureTime.compareTo(a.departureTime));
      }

      return flightList;
    } on FirebaseException catch (e) {
      print(e);
      return flightList;
    } catch (e) {
      print('demo error ${e}');
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<BookingFlight>> getListFlightByEmail(String email) async {
    List<BookingFlight> bookingList = [];

    try {
      final bookingSnapshot = await FirebaseFirestore.instance
          .collection(CollectionConstant.BOOKING_FLIGHT_COLLECTION)
          .where('email', isEqualTo: email)
          .get();

      if (bookingSnapshot.docs.isNotEmpty) {
        bookingList = bookingSnapshot.docs
            .map((doc) => BookingFlight.fromJson(
                doc.data() as Map<String, dynamic>? ?? {}))
            .toList();
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return bookingList;
  }
}
