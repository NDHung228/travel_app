import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travo_app/constant/utils/collection_constant.dart';
import 'package:travo_app/models/place_model.dart';
import 'package:travo_app/repo/place_repo/place_repo.dart';

class PlaceImplement implements PlaceRepository {
  @override
  Future<List<Place>> getPlaces() async {
    List<Place> placeList = [];
    try {
      final places = await FirebaseFirestore.instance.collection(CollectionConstant.PLACE_COLLECTION).get();
      
      places.docs.forEach((element) {
        return placeList.add(Place.fromJson(element.data()));
      });
      return placeList;
    } on FirebaseException catch (e) {
      print(e);
      return placeList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
