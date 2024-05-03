import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travo_app/constant/utils/collection_constant.dart';
import 'package:travo_app/models/promo_model.dart';
import 'package:travo_app/repo/promo_repo/promo_repo.dart';

class PromoImplement implements PromoRepository {
  @override
  Future<Promo?> checkPromo(String code) async {
    try {
      // Query Firestore for the promo with the given code
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(CollectionConstant.PROMO_COLLECTION)
          .where('code', isEqualTo: code)
          .get();

      // If the query has results, return the first promo found
      if (querySnapshot.docs.isNotEmpty) {
        var promoData = querySnapshot.docs.first.data()
            as Map<String, dynamic>; // Cast to the appropriate type
        return Promo.fromJson(promoData);
      } else {
        // If no promo is found, return null
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error searching promo: $e');
      return null;
    }
  }
}
