import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travo_app/models/review_model.dart';
import 'package:travo_app/repo/review_hotel_repo/review_hotel_impl.dart';
import 'package:travo_app/repo/review_hotel_repo/review_hotel_repo.dart';

part 'review_hotel_event.dart';
part 'review_hotel_state.dart';

class ReviewHotelBloc extends Bloc<ReviewHotelEvent, ReviewHotelState> {
  ReviewHotelBloc() : super(ReviewHotelInitial()) {
    on<ReviewHotelEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ReviewHotelRequiredByHotelId>(_onReviewHotelRequiredByHotelId);
  }

  void _onReviewHotelRequiredByHotelId(ReviewHotelRequiredByHotelId event,
      Emitter<ReviewHotelState> emit) async {
    emit(ReviewHotelLoading());
    try {
      final ReviewHotelRepository reviewHotelRepository =
          ReviewHotelImplement();
      final data =
          await reviewHotelRepository.getListReviewByHotelId(event.hotelId);
      emit(ReviewHotelLoaded(data));
    } catch (e) {
      emit(ReviewHotelFailure());
    }
  }
}
