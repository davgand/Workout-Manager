import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/screens/day_details_screen.dart';

class DaysList extends StatelessWidget {
  final List<Day> days;

  const DaysList({
    super.key,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutModel>(builder: (content, workout, child) {
      return ListView.builder(
          itemCount: days.length,
          itemBuilder: (context, index) => ListTile(
                leading: Text(index.toString()),
                title: Text(days[index].description,
                    style: AppStyles.textListStyle),
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
                    onPressed: () => {}, icon: Icon(Icons.edit, size: 24.0)),
              ));
    });
  }
}
