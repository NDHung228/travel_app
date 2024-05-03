import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  final String? hotelId;
  final String image;
  final String information;
  final String location;
  final String location_description;
  final String name;
  final double price;
  final double rating;
  final int total_review;

  const Hotel({
    this.hotelId,
    required this.image,
    required this.information,
    required this.location,
    required this.location_description,
    required this.name,
    required this.price,
    required this.rating,
    required this.total_review,
  });

  

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelId: json['hotelId'] ?? '',
      image: json['image'] ?? '',
      information: json['information'] ?? '',
      location: json['location'] ?? '',
      location_description: json['location_description'] ?? '',
      name: json['name'] ?? '',
      price: json['price'].toDouble() ?? 0,
      rating: json['rating'].toDouble() ?? 0,
      total_review: json['total_review'] ?? 0,
    );
  }

    Hotel copyWith({String? hotelId}) {
    return Hotel(
      hotelId: hotelId ?? this.hotelId,
      image: this.image,
      information: this.information,
      location: this.location,
      location_description: this.location_description,
      name: this.name,
      price: this.price,
      rating: this.rating,
      total_review: this.total_review,
    );
  }

  @override
  List<Object?> get props => [
        hotelId,
        image,
        information,
        location,
        location_description,
        name,
        price,
        rating,
        total_review,
      ];
}
