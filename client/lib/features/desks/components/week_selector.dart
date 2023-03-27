import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trollo/features/desks/data/desk.dart';

class WeekSelector extends ConsumerStatefulWidget {
  const WeekSelector({Key? key}) : super(key: key);

  @override
  _WeekSelectorState createState() => _WeekSelectorState();
}

class _WeekSelectorState extends ConsumerState<WeekSelector> {
  late DateTime _selectedDate;
  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dateFormat = DateFormat('dd.MM.yyyy');
  }

  void _previousWeek() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 7));
      ref.read(selectedWeekProvider.notifier).state = _selectedDate;
    });
  }

  void _nextWeek() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 7));
      ref.read(selectedWeekProvider.notifier).state = _selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(selectedWeekProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _previousWeek,
          icon: const Icon(Icons.arrow_left),
        ),
        Text(
          '${_dateFormat.format(_selectedDate.subtract(Duration(days: _selectedDate.weekday - 1)))} - ${_dateFormat.format(_selectedDate.add(Duration(days: 7 - _selectedDate.weekday)))}',
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          onPressed: _nextWeek,
          icon: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}
