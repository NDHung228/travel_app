part of 'booking_flight_bloc.dart';

sealed class BookingFlightState extends Equatable {
  const BookingFlightState();

  @override
  List<Object> get props => [];
}

final class BookingFlightInitial extends BookingFlightState {}

final class UpdateBookingFlight extends BookingFlightState {
  final BookingFlight bookingFlight;

  const UpdateBookingFlight(this.bookingFlight);

  @override
  List<Object> get props => [bookingFlight];
}

final class BookingFlightFailure extends BookingFlightState {
  final String errorMsg;

  const BookingFlightFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}

final class GetListFLightLoading extends BookingFlightState {}

final class GetListFLightFailure extends BookingFlightState {
  final String errorMSg;

  const GetListFLightFailure(this.errorMSg);
}

final class GetListFlightLoaded extends BookingFlightState {
  final List<Flight> listFlight;

  const GetListFlightLoaded(this.listFlight);
}

final class BookingFlightUpLoading extends BookingFlightState {}

final class BookingFlightUploadSuccess extends BookingFlightState {}

final class BookingFlightUploadFailure extends BookingFlightState {
  final String errorMsg;

  const BookingFlightUploadFailure(this.errorMsg);
}

final class SearchFlightLoaded extends BookingFlightState {
  final List<Flight> listFlight;
  final SearchFlightModel? searchFlightModel;
  const SearchFlightLoaded({required this.listFlight, this.searchFlightModel});
}
