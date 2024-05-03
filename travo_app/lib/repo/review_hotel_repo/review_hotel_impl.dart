import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travo_app/constant/utils/collection_constant.dart';
import 'package:travo_app/models/review_model.dart';
import 'package:travo_app/repo/review_hotel_repo/review_hotel_repo.dart';

class ReviewHotelImplement implements ReviewHotelRepository {
  @override
  Future<List<ReviewModel>> getListReviewByHotelId(String hotelId) async {
    try {
      // Query Firestore for reviews with the given hotel ID
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(CollectionConstant.REVIEW_COLLECTION)
          .where('Hotel Id', isEqualTo: hotelId)
          .get();

      // Check if there are any results
      if (querySnapshot.docs.isNotEmpty) {
        // Extract the list of reviews from the query documents
        final List<ReviewModel> reviews = querySnapshot.docs
            .map((QueryDocumentSnapshot doc) =>
                ReviewModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        return reviews;
      } else {
        return []; // Return an empty list if no reviews found
      }
    } catch (e) {
      // Handle errors
      print('Error searching reviews: $e');
      return [];
    }
  }
}
