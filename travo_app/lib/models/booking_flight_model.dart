import 'package:equatable/equatable.dart';
import 'package:travo_app/models/contact_detail_model.dart';
import 'package:travo_app/models/seat_model.dart';
import 'package:travo_app/pages/booking_flight/one_way_search_flight.dart';

// ignore: must_be_immutable
class BookingFlight extends Equatable {
  String? dateEnd;
  String? dateStart;
  String? email;
  List<ContactDetail>? guest;
  String? flight;
  String? typePayment;
  double? promoCode;
  double? price;
  String? from;
  String? to;
  int? passengers;
  List<String>? classSeats;
  List<TypeClass>? passengerClasses;
  List<Seat>? listSeat;
  String? airLine;
  String? dateTime;
  String? hourTime;
  String? flightNumber;
  String? name;

  BookingFlight({
    this.dateEnd,
    this.dateStart,
    this.email,
    this.guest,
    this.flight,
    this.typePayment,
    this.promoCode,
    this.price,
    this.from,
    this.to,
    this.passengers,
    this.classSeats,
    this.passengerClasses,
    this.listSeat,
    this.airLine,
    this.dateTime,
    this.hourTime,
    this.flightNumber,
    this.name,
  });

  factory BookingFlight.fromJson(Map<String, dynamic> json) {
    return BookingFlight(
      hourTime: json['hourTime'] ?? '',
      dateEnd: json['date_end'] ?? '',
      flightNumber: json['flightNumber'] ?? '',
      dateStart: json['date_start'] ?? '',
      dateTime: json['date_time'] ?? '',
      email: json['email'] ?? '',
      guest: (json['guest'] as List<dynamic>?)
          ?.map((guestJson) => ContactDetail.fromJson(guestJson))
          .toList(),
      flight: json['flight'] ?? '',
      typePayment: json['type_payment'] ?? '',
      promoCode: json['promo_code']?.toDouble() ?? 0,
      price: json['price']?.toDouble() ?? 0,
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      airLine: json['airLine'] ?? '',
      passengers: json['passengers'] ?? 0,
      classSeats: (json['classSeats'] as List<dynamic>?)
          ?.map((classSeat) => classSeat.toString())
          .toList(),
      passengerClasses: (json['passengerClasses'] as List<dynamic>?)
          ?.map((classSeat) => TypeClass.values[classSeat])
          .toList(),
      name: json['name'] ?? '',
      listSeat: (json['listSeat'] as List<dynamic>?)
          ?.map((seatJson) => Seat.fromJson(seatJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_end': dateEnd,
      'airLine': airLine,
      'hourTime': hourTime,
      'flightNumber': flightNumber,
      'date_start': dateStart,
      'date_time': dateTime,
      'email': email,
      'guest': guest?.map((contactDetail) => contactDetail.toJson()).toList(),
      'flight': flight,
      'type_payment': typePayment,
      'promo_code': promoCode,
      'price': price,
      'from': from,
      'to': to,
      'passengers': passengers,
      'classSeats': classSeats,
      'passengerClasses':
          passengerClasses?.map((typeClass) => typeClass.index).toList(),
      'name': name,
      'listSeat': listSeat?.map((seat) => seat.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        flightNumber,
        dateEnd,
        airLine,
        dateStart,
        dateTime,
        email,
        guest,
        flight,
        typePayment,
        promoCode,
        price,
        from,
        to,
        passengers,
        classSeats,
        passengerClasses,
        name,
        hourTime
      ];
}
