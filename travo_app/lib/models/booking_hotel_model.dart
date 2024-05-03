import 'package:equatable/equatable.dart';
import 'package:travo_app/models/contact_detail_model.dart';

// ignore: must_be_immutable
class BookingHotel extends Equatable {
  String? date_end;
  String? date_start;
  String? email;
  List<ContactDetail>? guest;
  String? hotel;
  String? room;
  String? type_payment;
  double? promo_code;
  double? price;

  BookingHotel(
      {this.date_end,
      this.date_start,
      this.email,
      this.guest,
      this.hotel,
      this.room,
      this.type_payment,
      this.promo_code,
      this.price});

  factory BookingHotel.fromJson(Map<String, dynamic> json) {
    return BookingHotel(
      date_end: json['date_end'] ?? '',
      date_start: json['date_start'] ?? '',
      email: json['email'] ?? '',
      guest: (json['guest'] as List<dynamic>?)
          ?.map((guestJson) => ContactDetail.fromJson(guestJson))
          .toList(),
      hotel: json['hotel'] ?? '',
      room: json['room'] ?? '',
      type_payment: json['type_payment'] ?? '',
      promo_code: json['promo_code'] ?? 0,
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_end': date_end,
      'date_start': date_start,
      'email': email,
      'guest': guest?.map((contactDetail) => contactDetail.toJson()).toList(),
      'hotel': hotel,
      'room': room,
      'type_payment': type_payment,
      'promo_code': promo_code,
      'price': price
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        date_end,
        date_start,
        email,
        guest,
        hotel,
        room,
        type_payment,
        promo_code,
        price
      ];
}
