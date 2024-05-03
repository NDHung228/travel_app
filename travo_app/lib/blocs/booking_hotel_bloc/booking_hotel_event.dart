part of 'booking_hotel_bloc.dart';

sealed class BookingHotelEvent extends Equatable {
  const BookingHotelEvent();

  @override
  List<Object> get props => [];
}

final class BookingHotelRequired extends BookingHotelEvent {
  final BookingHotel bookingHotel;

  const BookingHotelRequired({required this.bookingHotel});
}

