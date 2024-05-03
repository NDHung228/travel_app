part of 'seat_flight_bloc.dart';

sealed class SeatFlightEvent extends Equatable {
  const SeatFlightEvent();

  @override
  List<Object> get props => [];
}

class SeatClickedEvent extends SeatFlightEvent {
  final int indexType;
  final int indexRow;
  final int indexColumn;
  final List<dynamic> listSeat;
  final List<Seat> listChosen;
  final List<TypeClass> listType;
  final int numberPassenger;

  const SeatClickedEvent(this.indexType, this.indexRow, this.indexColumn,
      this.listSeat, this.listChosen, this.numberPassenger,this.listType);

  @override
  List<Object> get props => [indexType, indexRow, indexColumn];
}
