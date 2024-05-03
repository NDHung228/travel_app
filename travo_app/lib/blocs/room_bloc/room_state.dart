part of 'room_bloc.dart';

sealed class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

// ignore: must_be_immutable
class RoomLoaded extends RoomState {
  List<Room> roomList;

  RoomLoaded(this.roomList);
  @override
  List<Object> get props => [roomList];
}

class RoomError extends RoomState {
  final String error;

  const RoomError(this.error);
  @override
  List<Object> get props => [error];
}


final class GetRoomLoadingById extends RoomState{}

final class GetRoomLoadedById extends RoomState {
  final Room room;

  const GetRoomLoadedById({required this.room});
}
