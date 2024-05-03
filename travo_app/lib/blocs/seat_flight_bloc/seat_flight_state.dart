part of 'seat_flight_bloc.dart';

sealed class SeatFlightState extends Equatable {
  const SeatFlightState();

  @override
  List<Object> get props => [];
}

final class SeatFlightInitial extends SeatFlightState {}

class SeatUpdatedState extends SeatFlightState {
  final List<dynamic> updatedListSeat;
  final List<Seat> listSeat;
  final Map<String, int> classCountMap;
  const SeatUpdatedState(
      this.updatedListSeat, this.listSeat, this.classCountMap);
}

class SeatUpdatingState extends SeatFlightState {}
