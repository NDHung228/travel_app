part of 'review_hotel_bloc.dart';

sealed class ReviewHotelEvent extends Equatable {
  const ReviewHotelEvent();

  @override
  List<Object> get props => [];
}

class ReviewHotelRequiredByHotelId extends ReviewHotelEvent {
  final String hotelId;
  const ReviewHotelRequiredByHotelId(this.hotelId);
}
