import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/repo/room_repo/room_impl.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial()) {
    on<RoomEvent>((event, emit) {});

    on<GetRoom>(_onRoomGetData);
    on<GetRoomRequiredById>(_onGetRoomById);
  }

  void _onRoomGetData(GetRoom event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    final RoomImplement roomRepository = RoomImplement();
    try {
      final data = await roomRepository.getRooms(event.hotelId);
      emit(RoomLoaded(data));
    } catch (e) {
      emit(RoomError(e.toString()));
    }
  }

  void _onGetRoomById(
      GetRoomRequiredById event, Emitter<RoomState> emit) async {
    emit(GetRoomLoadingById());
    {
      try {
        final RoomImplement roomRepository = RoomImplement();

        Room data = await roomRepository.getRoomById(event.roomId);
        emit(GetRoomLoadedById(room: data));
      } catch (e) {
        emit(RoomError(e.toString()));
      }
    }
  }
}
