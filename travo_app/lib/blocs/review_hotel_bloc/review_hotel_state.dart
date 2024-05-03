part of 'review_hotel_bloc.dart';

sealed class ReviewHotelState extends Equatable {
  const ReviewHotelState();

  @override
  List<Object> get props => [];
}

final class ReviewHotelInitial extends ReviewHotelState {}

final class ReviewHotelLoading extends ReviewHotelState {}

final class ReviewHotelLoaded extends ReviewHotelState {
  final List<ReviewModel> reviews;
  const ReviewHotelLoaded(this.reviews);
}

final class ReviewHotelFailure extends ReviewHotelState {
  
}
