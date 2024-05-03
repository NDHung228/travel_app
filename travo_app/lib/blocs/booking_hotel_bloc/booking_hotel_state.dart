part of 'booking_hotel_bloc.dart';

sealed class BookingHotelState extends Equatable {
  const BookingHotelState();

  @override
  List<Object> get props => [];
}

final class BookingHotelInitial extends BookingHotelState {}

final class BookingHotelLoading extends BookingHotelState {}

final class BookingHotelSuccess extends BookingHotelState {}

class BookingHotelFailure extends BookingHotelState {
  final String errorMsg;

  const BookingHotelFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
