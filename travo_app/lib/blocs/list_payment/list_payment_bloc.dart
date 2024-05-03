import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/repo/booking_flight_repo/booking_flight_impl.dart';
import 'package:travo_app/repo/booking_flight_repo/booking_flight_repository.dart';
import 'package:travo_app/repo/room_repo/room_impl.dart';
import 'package:travo_app/repo/room_repo/room_repo.dart';

part 'list_payment_event.dart';
part 'list_payment_state.dart';

class ListPaymentBloc extends Bloc<ListPaymentEvent, ListPaymentState> {
  ListPaymentBloc() : super(ListPaymentInitial()) {
    on<ListPaymentEvent>((event, emit) {});

    on<GetListPaymentRoomRequired>(_onGetListPaymentRoomRequired);

    on<GetListPaymentFlightRequired>(_onGetListPaymentFlightRequired);
  }

  void _onGetListPaymentRoomRequired(
      GetListPaymentRoomRequired event, Emitter<ListPaymentState> emit) async {
    final RoomRepository roomRepository = RoomImplement();
    emit(ListPaymentRoomLoading());
    try {
      List<BookingHotel> data = await roomRepository.getListBookingHotel(event.email);
      emit(ListPaymentRoomLoaded(data));
    } catch (e) {
      emit(ListPaymentRoomFailure(e.toString()));
    }
  }

  void _onGetListPaymentFlightRequired(
      GetListPaymentFlightRequired event, Emitter<ListPaymentState> emit) async {
    final BookingFlightRepository flightRepository = BookingFlightImplement();
    emit(ListPaymentFlightLoading());
    try {
      List<BookingFlight>data = await flightRepository.getListFlightByEmail(event.email);
      emit(ListPaymentFlightLoaded(data));
    } catch (e) {
      emit(ListPaymentRoomFailure(e.toString()));
    }
  }

}
