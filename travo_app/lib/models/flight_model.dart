import 'package:cloud_firestore/cloud_firestore.dart';

class Flight {
  final String airline;
  final DateTime departureTime;
  final DateTime arriveTime;
  final String fromPlace;
  final String toPlace;
  final String flightNumber;
  final double price;
  final List<dynamic>? seatAvailability;

  Flight({
    required this.airline,
    required this.departureTime,
    required this.arriveTime,
    required this.fromPlace,
    required this.toPlace,
    required this.flightNumber,
    required this.price,
    this.seatAvailability,
  });

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
        airline: map['airline'] ?? '',
        departureTime: (map['departure_time'] as Timestamp).toDate(),
        arriveTime: (map['arrive_time'] as Timestamp).toDate(),
        fromPlace: map['from_place'] ?? '',
        toPlace: map['to_place'] ?? '',
        flightNumber: map['no'] ?? '',
        price: (map['price'] ?? 0).toDouble(),
        seatAvailability: map['seat'] as List<dynamic>);
  }

  Flight copyWith({
    String? airline,
    DateTime? departureTime,
    DateTime? arriveTime,
    String? fromPlace,
    String? toPlace,
    String? flightNumber,
    double? price,
    List<dynamic>? seatAvailability,
  }) {
    return Flight(
      airline: airline ?? this.airline,
      departureTime: departureTime ?? this.departureTime,
      arriveTime: arriveTime ?? this.arriveTime,
      fromPlace: fromPlace ?? this.fromPlace,
      toPlace: toPlace ?? this.toPlace,
      flightNumber: flightNumber ?? this.flightNumber,
      price: price ?? this.price,
      seatAvailability:
          seatAvailability ?? List.from(this.seatAvailability ?? []),
    );
  }
}
