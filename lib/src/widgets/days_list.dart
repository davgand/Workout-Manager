import 'package:flutter/material.dart';
import 'package:gym_manager/src/constants/app_styles.dart';
import 'package:gym_manager/src/model/day.dart';

class DaysList extends StatelessWidget {
  final List<Day> days;
  final ValueChanged<Day>? onTap;

  const DaysList({
    required this.days,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: days.length,
      itemBuilder: (context, index) => ListTile(
            leading: Text(index.toString()),
            title:
                Text(days[index].description, style: AppStyles.textListStyle),
            onTap: onTap != null ? () => onTap!(days[index]) : null,
            minVerticalPadding: 50,
            titleAlignment: ListTileTitleAlignment.center,
            trailing: IconButton(
                onPressed: () => {days[index].description = "Prova"},
                icon: Icon(Icons.edit, size: 24.0)),
          ));
}
