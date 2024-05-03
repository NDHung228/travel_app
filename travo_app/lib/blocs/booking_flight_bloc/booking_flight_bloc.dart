import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/flight_model.dart';
import 'package:travo_app/models/search_flight_model.dart';
import 'package:travo_app/repo/booking_flight_repo/booking_flight_impl.dart';
import 'package:travo_app/repo/booking_flight_repo/booking_flight_repository.dart';

part 'booking_flight_event.dart';
part 'booking_flight_state.dart';

class BookingFlightBloc extends Bloc<BookingFlightEvent, BookingFlightState> {
  BookingFlightBloc() : super(BookingFlightInitial()) {
    on<BookingFlightEvent>((event, emit) {});

    on<BookingFlightSaveRequired>(_saveBookingFlight);

    on<ListFlightRequired>(_getListFlight);

    on<BookingFlightRequired>(_addToFireBaseBookingFlight);

    on<SearchFlightRequired>(_searchFlight);
  }

  void _searchFlight(
      SearchFlightRequired event, Emitter<BookingFlightState> emit) async {
    try {

      BookingFlightRepository flightRepository = BookingFlightImplement();
      SearchFlightModel? searchListFlight = event.searchFlightModel;
      if (state is SearchFlightLoaded) {
        searchListFlight ??= (state as SearchFlightLoaded).searchFlightModel;
      }
      List<Flight> listFlight =
          await flightRepository.searchListFlight(searchListFlight!);

      emit(GetListFLightLoading());

      emit(SearchFlightLoaded(
          listFlight: listFlight, searchFlightModel: searchListFlight));
    } catch (e) {
      emit(GetListFLightFailure(e.toString()));
    }
  }

  void _saveBookingFlight(
      BookingFlightSaveRequired event, Emitter<BookingFlightState> emit) async {
    try {
      emit(UpdateBookingFlight(event.bookingFlight));
    } catch (e) {
      emit(BookingFlightFailure(e.toString()));
    }
  }

  void _getListFlight(
      ListFlightRequired event, Emitter<BookingFlightState> emit) async {
    emit(GetListFLightLoading());
    try {
      BookingFlightRepository bookingFlightRepository =
          BookingFlightImplement();
      List<Flight> listFlight = await bookingFlightRepository.getListFlight();
      emit(GetListFlightLoaded(listFlight));
    } catch (e) {
      print(e);
    }
  }

  void _addToFireBaseBookingFlight(
      BookingFlightRequired event, Emitter<BookingFlightState> emit) async {
    emit(BookingFlightUpLoading());

    try {
      final BookingFlightRepository bookingFlightRepository =
          BookingFlightImplement();
      bookingFlightRepository.bookingFlight(event.bookingFlight);
      emit(BookingFlightUploadSuccess());
    } catch (e) {
      emit(BookingFlightUploadFailure(e.toString()));
    }
  }
}
