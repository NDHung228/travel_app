import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String roomId;
  final String hotelId;
  final String image;
  final int maxGuest;
  final String name;
  final double price;
  final List<String> services;
  final int total;
  final String typePrice;

  const Room({
    required this.roomId,
    required this.hotelId,
    required this.image,
    required this.maxGuest,
    required this.name,
    required this.price,
    required this.services,
    required this.total,
    required this.typePrice,
  });

    Room copyWith({
    String? roomId,
    String? hotelId,
    String? image,
    int? maxGuest,
    String? name,
    double? price,
    List<String>? services,
    int? total,
    String? typePrice,
  }) {
    return Room(
      roomId: roomId ?? this.roomId,
      hotelId: hotelId ?? this.hotelId,
      image: image ?? this.image,
      maxGuest: maxGuest ?? this.maxGuest,
      name: name ?? this.name,
      price: price ?? this.price,
      services: services ?? this.services,
      total: total ?? this.total,
      typePrice: typePrice ?? this.typePrice,
    );
  }


  factory Room.fromJson(Map<String, dynamic> json) {
    List<String> services = [];
    if (json['services'] != null) {
      services = List<String>.from(json['services']);
    }
    return Room(
      roomId: json['room'] ?? '',
      hotelId: json['hotel'] ?? '',
      image: json['image'] ?? '',
      maxGuest: json['max_guest'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'].toDouble() ?? 0,
      services: services,
      total: json['total'] ?? 0,
      typePrice: json['type_price'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        roomId,
        hotelId,
        image,
        maxGuest,
        name,
        price,
        services,
        total,
        typePrice,
      ];
}
