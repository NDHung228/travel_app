import 'package:travo_app/models/promo_model.dart';

abstract class PromoRepository  {
  Future<Promo?> checkPromo(String code);
}