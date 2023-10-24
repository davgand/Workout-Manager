import 'package:flutter/material.dart';
import 'package:workout_manager/src/model/day.dart';

class DayItem extends StatelessWidget {
  final Day day;

  const DayItem({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        child: Center(child: Text(day.description)),
      ),
    );
  }
}
