import 'package:travo_app/models/review_model.dart';

abstract class ReviewHotelRepository  {
  Future<List<ReviewModel>> getListReviewByHotelId(String hotelId);
}