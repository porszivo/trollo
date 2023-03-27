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
  Future<List<Desk>> getDesks(String startDate) async {
    Response response = await get(Uri.parse('$endpoint/$startDate'));
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

final deskDataProvider = FutureProvider.autoDispose<List<Desk>>((ref) async {
  final selectedWeek = ref.watch(selectedWeekProvider);
  final desks = await ref.watch(deskProvider).getDesks(selectedWeek.toString());
  return desks;
});

final selectedWeekProvider = StateProvider<DateTime>((ref) => DateTime.now());
