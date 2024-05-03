// ignore_for_file: must_be_immutable

part of 'place_bloc.dart';

sealed class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

final class PlaceInitial extends PlaceState {}

class PlaceError extends PlaceState {
  final String error;

  const PlaceError(this.error);

  @override
  List<Object> get props => [error];
}

class PlaceLoading extends PlaceState {
  @override
  List<Object> get props => [];
}

class PlaceLoaded extends PlaceState {
  List<Place> placeList;

  PlaceLoaded(this.placeList);
    @override
  List<Object> get props => [placeList];
}
