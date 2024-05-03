import 'package:travo_app/models/hotel.model.dart';

abstract class HotelRepository {
  Future<List<Hotel>> getHotels();

  Future<List<Hotel>> searchHotels(String keyword);

  Future<List<Hotel>> filterHotels(String? keyword,double? startPrice, double? endPrice,String? sort);
}
