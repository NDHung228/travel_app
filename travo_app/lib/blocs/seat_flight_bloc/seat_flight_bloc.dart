import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travo_app/models/seat_model.dart';
import 'package:travo_app/pages/booking_flight/one_way_search_flight.dart';

part 'seat_flight_event.dart';
part 'seat_flight_state.dart';

class SeatFlightBloc extends Bloc<SeatFlightEvent, SeatFlightState> {
  final List<dynamic> listSeatInitial;
  SeatFlightBloc({required this.listSeatInitial}) : super(SeatFlightInitial()) {
    on<SeatClickedEvent>(_onSeatClickedEvent);
  }

  void _onSeatClickedEvent(
      SeatClickedEvent event, Emitter<SeatFlightState> emit) {
    final indexType = event.indexType;
    final indexRow = event.indexRow;
    final indexColumn = event.indexColumn;
    final numberPassenger = event.numberPassenger;
    final List<dynamic> updatedListSeat = (state is SeatUpdatedState)
        ? List.from((state as SeatUpdatedState).updatedListSeat)
        : event.listSeat;

    final List<Seat> listSeatChosen = event.listChosen;

    List<TypeClass> listType = event.listType;

    final Map<String, int> classCountMap = (state is SeatUpdatedState)
        ? (state as SeatUpdatedState).classCountMap
        : {
            'Business': 0,
            'Economy': 0,
          };
    if (state is SeatUpdatedState == false) {
      listType.map((typeClass) => typeClass.name).forEach((className) {
        classCountMap[className] = (classCountMap[className] ?? 0) + 1;
      });
    }
    print('demo Business  ${classCountMap['Business']}');
    print('demo Economy ${classCountMap['Economy']}');


    emit(SeatUpdatingState());

    if (updatedListSeat[indexType].values.toList()[indexColumn][indexRow]) {
      if (listSeatChosen.isEmpty) {
        Seat seat = Seat(indexType, indexColumn, indexRow,
            isAvailable: true,
            position: _calculatePosition(indexColumn, indexRow),
            typeClass: _calculateTypeClass(indexType));
        if (classCountMap[seat.typeClass]! > 0) {
          listSeatChosen.add(seat);
          classCountMap[seat.typeClass!] = classCountMap[seat.typeClass]! - 1;
        }
      } else {
        Seat newSeat = Seat(indexType, indexColumn, indexRow,
            isAvailable: true,
            position: _calculatePosition(indexColumn, indexRow),
            typeClass: _calculateTypeClass(indexType));
        bool isAlreadyChosen = false;

        for (Seat seat in listSeatChosen) {
          if (seat.index == newSeat.index &&
              seat.row == newSeat.row &&
              seat.column == newSeat.column) {
            isAlreadyChosen = true;
            listSeatChosen.removeWhere((seat) =>
                seat.index == indexType &&
                seat.row == indexRow &&
                seat.column == indexColumn);
            classCountMap[newSeat.typeClass!] =
                classCountMap[newSeat.typeClass]! + 1;
  
            break;
          }
        }

        if (!isAlreadyChosen && listSeatChosen.length < numberPassenger) {
          if (classCountMap[newSeat.typeClass]! > 0) {
            listSeatChosen.add(newSeat);
            classCountMap[newSeat.typeClass!] =
                classCountMap[newSeat.typeClass]! - 1;
          }
        }
      }
    }

    emit(SeatUpdatedState(updatedListSeat, listSeatChosen, classCountMap));
  }

  String _calculatePosition(int column, int row) {
    final List<String> seatIdentifiers = ['A', 'B', 'C', 'D', 'E', 'F'];
    return '${column + 1}${seatIdentifiers[row]}';
  }

  String _calculateTypeClass(int indexType) {
    return indexType == 0 ? 'Business' : 'Economy';
  }
}
