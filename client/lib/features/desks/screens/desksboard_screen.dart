import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trollo/features/desks/data/desk.dart';

class DesksboardScreen extends ConsumerWidget {
  const DesksboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _desks = ref.watch(deskDataProvider);
    return Scaffold(
      body: _desks.when(
          data: (_data) {
            List<Desk> userList = _data.map((e) => e).toList();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (_, index) {
                            return Card(
                              color: Colors.blue,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(userList[index].name),
                              ),
                            );
                          }))
                ],
              ),
            );
          },
          error: (err, s) => Text(err.toString()),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
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
