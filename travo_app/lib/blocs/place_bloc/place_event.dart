part of 'place_bloc.dart';

sealed class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}


class GetPlace extends PlaceEvent {
  const GetPlace();
}