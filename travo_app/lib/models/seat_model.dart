class Seat {
  final bool isAvailable;
  final int index;
  final int column;
  final int row;
  final String? position;
  final String? typeClass;

  Seat(
    this.index,
    this.column,
    this.row, {
    required this.isAvailable,
    this.position,
    this.typeClass,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      json['index'] ?? 0,
      json['column'] ?? 0,
      json['row'] ?? 0,
      isAvailable: json['is_available'] ?? false,
      position: json['position'],
      typeClass: json['type_class'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'column': column,
      'row': row,
      'is_available': isAvailable,
      'position': position,
      'type_class': typeClass,
    };
  }
}
