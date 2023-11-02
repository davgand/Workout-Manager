import 'package:flutter/material.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/widgets/day_popup.dart';
import 'package:workout_manager/src/widgets/days_list.dart';

class WorkoutScreen extends StatelessWidget {
  final String title = 'Workout';
  final WorkoutModel workout;

  const WorkoutScreen({super.key, required this.workout});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayDayDialog(context);
        },
        shape: AppStyles.floatButtonShape,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(title),
      ),
      body: DaysList(days: workout.days),
    );
  }

  Future<void> displayDayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return DayDialog();
        });
  }
}
