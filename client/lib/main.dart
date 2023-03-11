import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trollo/features/taskboard/screen/taskboard_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: TaskboardScreen(),
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
      ),
    );
  }
}
