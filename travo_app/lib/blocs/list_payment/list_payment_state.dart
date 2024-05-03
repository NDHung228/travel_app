part of 'list_payment_bloc.dart';

sealed class ListPaymentState extends Equatable {
  const ListPaymentState();

  @override
  List<Object> get props => [];
}

final class ListPaymentInitial extends ListPaymentState {}

final class ListPaymentRoomLoading extends ListPaymentState {}

final class ListPaymentRoomLoaded extends ListPaymentState {
  final List<BookingHotel> bookingHotel;

  const ListPaymentRoomLoaded(this.bookingHotel);
  @override
  List<Object> get props => [bookingHotel];
}

final class ListPaymentRoomFailure extends ListPaymentState {
  final String errorMsg;

  const ListPaymentRoomFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}

final class ListPaymentFlightLoading extends ListPaymentState {}

final class ListPaymentFlightLoaded extends ListPaymentState {
  final List<BookingFlight> listBookingFlight;

  const ListPaymentFlightLoaded(this.listBookingFlight);
  @override
  List<Object> get props => [listBookingFlight];
}
