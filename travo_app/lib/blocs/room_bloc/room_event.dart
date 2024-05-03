part of 'room_bloc.dart';

sealed class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class GetRoom extends RoomEvent {
  final String hotelId;
  const GetRoom(this.hotelId);
  @override
  List<Object> get props => [hotelId];
}


class GetRoomRequiredById extends RoomEvent {
  final String roomId;
  const GetRoomRequiredById({required this.roomId});
}
