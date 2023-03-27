import 'package:flutter/material.dart';

class DeskDay extends StatelessWidget {
  const DeskDay({
    Key? key,
    required this.day,
    required this.onTap,
  }) : super(key: key);

  final String day;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Container(
          color: Colors.green,
          child: Text(day.substring(0, 2)),
        ),
        onTap: onTap,
      ),
    );
  }
}
