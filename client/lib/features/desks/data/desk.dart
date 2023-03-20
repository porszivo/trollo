import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:trollo/features/desks/data/reservation.dart';

class Desk {
  Desk(
      {required this.id,
      required this.room,
      required this.name,
      required this.reservations});

  final int id;
  final String room;
  final String name;
  final List<Reservation> reservations;

  factory Desk.fromJson(Map<String, dynamic> json) {
    return Desk(
      id: json['id'],
      name: json['name'],
      room: json['room'],
      reservations: List<Reservation>.from(
        json['reservations'].map(
          (reservation) => Reservation.fromJson(reservation),
        ),
      ),
    );
  }
}

class DeskService {
  String endpoint = 'http://localhost:3000/desks';
  Future<List<Desk>> getDesks() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((json) {
        return Desk.fromJson(json);
      }).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final deskProvider = Provider<DeskService>((ref) => DeskService());

final deskDataProvider = FutureProvider<List<Desk>>((ref) async {
  return ref.watch(deskProvider).getDesks();
});
