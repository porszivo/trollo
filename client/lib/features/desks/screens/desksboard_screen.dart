import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trollo/features/desks/components/desk_card.dart';
import 'package:trollo/features/desks/components/week_selector.dart';
import 'package:trollo/features/desks/data/desk.dart';

class DesksboardScreen extends ConsumerWidget {
  const DesksboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final desks = ref.watch(deskDataProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(ref.watch(selectedWeekProvider.notifier).state.toString()),
            const WeekSelector(),
            Expanded(
              child: desks.when(
                data: (data) {
                  List<Desk> deskList = data.map((e) => e).toList();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: deskList.length,
                            itemBuilder: (_, index) {
                              return DeskCard(
                                desk: deskList[index],
                                onReservationChanged: (Reservation, bool) {
                                  print(Reservation);
                                },
                                selectedWeek: DateTime.now(),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
                error: (err, s) => Text(err.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24),
        ),
        child: const Text(
          '+',
          style: TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}
