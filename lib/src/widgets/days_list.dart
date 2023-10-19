import 'package:flutter/material.dart';
import 'package:gym_manager/src/constants/app_styles.dart';
import 'package:gym_manager/src/model/day.dart';
import 'package:gym_manager/src/screens/day_details_screen.dart';

class DaysList extends StatelessWidget {
  final List<Day> days;

  const DaysList({
    required this.days,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: days.length,
      itemBuilder: (context, index) => ListTile(
              leading: Text(index.toString()),
              title:
                  Text(days[index].description, style: AppStyles.textListStyle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DayDetailsScreen(day: days[index]),
                  ),
                );
              },
              minVerticalPadding: 50,
              titleAlignment: ListTileTitleAlignment.center,
              trailing: IconButton(
                  onPressed: () => {days[index].description = "Prova"},
                  icon: Icon(Icons.edit, size: 24.0)),
            ));
  }
}
