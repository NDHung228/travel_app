  class ReviewModel {
  final String comment;
  final int dislike;
  final String emailUser;
  final String hotelId;
  final int like;
  final List<String> photos;
  final DateTime ratedTime;
  final int rating;
  final String uid;

  ReviewModel({
    required this.comment,
    required this.dislike,
    required this.emailUser,
    required this.hotelId,
    required this.like,
    required this.photos,
    required this.ratedTime,
    required this.rating,
    required this.uid,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      comment: json['Comment'] ?? '',
      dislike: json['Dislike'] ?? 0,
      emailUser: json['Email User'] ?? '',
      hotelId: json['Hotel Id'] ?? '',
      like: json['Like'] ?? 0,
      photos: List<String>.from(json['Photos'] ?? []),
      ratedTime: DateTime.parse(json['Rated Time'] ?? ''),
      rating: json['Rating'] ?? 0,
      uid: json['Uid'] ?? '',
    );
  }
}
