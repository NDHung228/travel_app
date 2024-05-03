import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travo_app/models/place_model.dart';

class HomeService {
  late SharedPreferences _prefs;

  HomeService() {
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void toggleFavorite(Place place) {
    List<Place> favoritePlaces = getFavoritePlaces();
    bool isFavorite = favoritePlaces.contains(place);

    if (!isFavorite) {
      favoritePlaces.add(place);
    } else {
      favoritePlaces.remove(place);
    }

    saveFavoritePlaces(favoritePlaces);
  }

  List<Place> getFavoritePlaces() {
    List<Place> listPlaceFavorite = [];
    final String? jsonString = _prefs.getString('favoritePlaces');
    if (jsonString != null && jsonString.isNotEmpty) {
      final List<dynamic> jsonList = json.decode(jsonString);
      listPlaceFavorite = jsonList.map((json) => Place.fromJson(json)).toList();
    }

    return listPlaceFavorite;
  }

  void saveFavoritePlaces(List<Place> favoritePlaces) {
    final List<Map<String, dynamic>> jsonList =
        favoritePlaces.map((place) => place.toJson()).toList();
    final String jsonString = json.encode(jsonList);
    _prefs.setString('favoritePlaces', jsonString);
  }
}
