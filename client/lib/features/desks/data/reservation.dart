class Reservation {
  Reservation({required this.id, required this.date});
  final int id;
  final DateTime date;

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      date: DateTime.parse(json['date']),
    );
  }
}
