import 'package:travo_app/models/place_model.dart';

abstract class PlaceRepository {

  Future<List<Place>> getPlaces() ;
}
