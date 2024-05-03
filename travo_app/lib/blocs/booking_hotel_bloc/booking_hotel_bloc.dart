
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/repo/booking_hotel_repo/booking_hotel_impl.dart';
import 'package:travo_app/repo/booking_hotel_repo/booking_hotel_repository.dart';

part 'booking_hotel_event.dart';
part 'booking_hotel_state.dart';

class BookingHotelBloc extends Bloc<BookingHotelEvent, BookingHotelState> {
  BookingHotelBloc() : super(BookingHotelInitial()) {
    on<BookingHotelEvent>((event, emit) {
      
    });
    on<BookingHotelRequired>(_onBookingHotel);
  }

  _onBookingHotel(
      BookingHotelRequired event, Emitter<BookingHotelState> emit) async {
    emit(BookingHotelLoading());

    try {
      final BookingHotelRepository bookingHotelRepository =
          BookingHotelImplement();
      bookingHotelRepository.bookingHotel(event.bookingHotel);
      emit(BookingHotelSuccess());
    } catch (e) {

      emit(BookingHotelFailure(errorMsg: e.toString()));
    }
  }
}
