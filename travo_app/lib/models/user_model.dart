import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String? userId;
  final String? avatar;
  final String? country;
  final String? name;
  final String? phone;
  final String? email;

  const MyUser({
    required this.userId,
    required this.avatar,
    required this.country,
    required this.name,
    required this.phone,
    required this.email,
  });

  static const empty = MyUser(
      userId: '', avatar: '', name: '', country: '', phone: '', email: '');

  MyUser copyWith(
      {String? userId,
      String? email,
      String? name,
      String? avatar,
      String? country,
      String? phone}) {
    return MyUser(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        country: country ?? this.country,
        phone: phone ?? this.phone);
  }

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      userId: json['userId'] ?? '',
      avatar: json['avatar'] ?? '',
      country: json['country'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'avatar': avatar,
      'country': country,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userId, avatar, country, name, phone, email];
}
