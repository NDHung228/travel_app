import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/flight_model.dart';
import 'package:travo_app/models/search_flight_model.dart';

abstract class BookingFlightRepository {
  Future<void> bookingFlight(BookingFlight bookingFlight);

  Future<List<Flight>> getListFlight();

  Future<List<Flight>> searchListFlight(SearchFlightModel searchFlight) ;

  Future<List<BookingFlight>> getListFlightByEmail(String email);

}
