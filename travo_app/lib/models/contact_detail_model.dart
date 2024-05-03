class ContactDetail {
  final String name;
  final String phone;
  final String email;

  ContactDetail({required this.name, required this.phone, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
    factory ContactDetail.fromJson(Map<String, dynamic> json) {
    return ContactDetail(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
