class Promo {
  final String? code;
  final String? endow;
  final String? image;
  final double? price;

  Promo({
    this.code,
    this.endow,
    this.image,
    this.price,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      code: json['code'] ?? '', // Using ?? to provide default value ''
      endow: json['endow'] ?? '', // Using ?? to provide default value ''
      image: json['image'] ?? '', // Using ?? to provide default value ''
      price: json['price']?.toDouble() ?? 0.0, // Using ?. operator to access property safely and ?? to provide default value 0.0
    );
  }
}
