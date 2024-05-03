part of 'booking_flight_bloc.dart';

sealed class BookingFlightEvent extends Equatable {
  const BookingFlightEvent();

  @override
  List<Object> get props => [];
}

class BookingFlightSaveRequired extends BookingFlightEvent {
  final BookingFlight bookingFlight;

  const BookingFlightSaveRequired(this.bookingFlight);
}

class ListFlightRequired extends BookingFlightEvent {}

class ChooseSeatRequired extends BookingFlightEvent {
  final int indexRow;
  final int indexColumn;
  final List<dynamic> seatAvailability;

  const ChooseSeatRequired(
      this.indexColumn, this.indexRow, this.seatAvailability);
}

class BookingFlightRequired extends BookingFlightEvent {
  final BookingFlight bookingFlight;

  const BookingFlightRequired(this.bookingFlight);
}

class SearchFlightRequired extends BookingFlightEvent {
  final SearchFlightModel? searchFlightModel;
  const SearchFlightRequired(this.searchFlightModel);
}
