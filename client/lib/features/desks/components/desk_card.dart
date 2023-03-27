import 'package:flutter/material.dart';
import 'package:trollo/features/desks/data/desk.dart';
import 'package:trollo/features/desks/data/reservation.dart';

import 'package:intl/intl.dart';

class ReservationButton extends StatelessWidget {
  final bool isReserved;
  final Function(bool) onReservationChanged;

  ReservationButton(
      {required this.isReserved, required this.onReservationChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onReservationChanged(!isReserved),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isReserved ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class DeskCard extends StatelessWidget {
  final Desk desk;
  final Function(Reservation, bool) onReservationChanged;
  final DateTime selectedWeek;

  const DeskCard(
      {super.key,
      required this.desk,
      required this.onReservationChanged,
      required this.selectedWeek});

  @override
  Widget build(BuildContext context) {
    final weekDays = List<DateTime>.generate(
        7, (index) => selectedWeek.add(Duration(days: index)));

    return Column(
      children: [
        Text(
          desk.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Table(
          columnWidths: {
            0: FixedColumnWidth(70),
            1: FixedColumnWidth(30),
            2: FixedColumnWidth(30),
            3: FixedColumnWidth(30),
            4: FixedColumnWidth(30),
            5: FixedColumnWidth(30),
            6: FixedColumnWidth(30),
            7: FixedColumnWidth(30),
          },
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    "Day",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                ...weekDays.map((date) => TableCell(
                      child: Text(
                        DateFormat('EEE').format(date),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    "Reserved",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                ...weekDays.map((date) {
                  final isReserved =
                      desk.reservations.any((r) => isSameDay(r.date, date));
                  return TableCell(
                    child: ReservationButton(
                      isReserved: isReserved,
                      onReservationChanged: (isReserved) =>
                          onReservationChanged(
                        Reservation(id: desk.id, date: date),
                        isReserved,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ],
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
