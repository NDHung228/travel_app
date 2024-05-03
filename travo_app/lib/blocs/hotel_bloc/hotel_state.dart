part of 'hotel_bloc.dart';

sealed class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

final class HotelInitial extends HotelState {}

class HotelError extends HotelState {
  final String error;

  const HotelError(this.error);

  @override
  List<Object> get props => [error];
}

class HotelLoading extends HotelState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class HotelLoaded extends HotelState {
  List<Hotel> hotelList;

  HotelLoaded(this.hotelList);
  @override
  List<Object> get props => [hotelList];
}

class SearchHotelLoading extends HotelState {}

// ignore: must_be_immutable
class SearchHotelLoaded extends HotelState {
  List<Hotel> hotelList;
  final String? keyword;
  final double? startPrice;
  final double? endPrice;
  final String? sort;

  SearchHotelLoaded(
      {required this.hotelList, this.keyword, this.startPrice, this.endPrice, this.sort });
  @override
  List<Object> get props => [hotelList];
}
