import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String img;
  final String name;
  final double rating;

  const Place({
    required this.img,
    required this.name,
    required this.rating,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      img: json['image'] ?? '',
      name: json['name'] ?? '',
      rating: json['rating'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': img,
      'name': name,
      'rating': rating,
    };
  }

  @override
  List<Object?> get props => [img, name, rating];
}
