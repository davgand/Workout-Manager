import 'package:flutter/material.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/widgets/day_item.dart';

class DaysList extends StatelessWidget {
  final List<Day> days;

  const DaysList({
    super.key,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
          itemCount: days.length,
        itemBuilder: (context, index) => DayItem(day: days[index]));
  }
}
