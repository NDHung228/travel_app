part of 'hotel_bloc.dart';

sealed class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class GetHotel extends HotelEvent {
  const GetHotel();
}

class SearchHotelRequired extends HotelEvent {
  final String? keyword;
  final double? startPrice;
  final double? endPrice;
  final String? sort;

  const SearchHotelRequired(
      {this.keyword, this.startPrice, this.endPrice, this.sort});
}
