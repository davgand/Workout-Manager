import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/model/workout.dart';

import 'exercise_popup.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;
  final Day day;

  const ExerciseItem(
      {super.key,
      required this.day,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: Key(day.id.toString()),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          //dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) => editExercise(context, day, exercise),
              backgroundColor: Palette.white,
              foregroundColor: Palette.grey,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (context) => deleteExercise(context, day, exercise),
              backgroundColor: Palette.red,
              foregroundColor: Palette.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: ListTile(
        title: Row(
      children: [
        Expanded(
            flex: 30,
            child: Column(children: [
              Text(style: AppStyles.exerciseTitleStyle, exercise.name)
            ])),
        Expanded(
            flex: 15,
            child: Column(children: [
              Text(exercise.reps.toString()),
            ])),
        Expanded(
            flex: 15,
            child: Column(children: [
              Text("${exercise.weight} kg"),
                ])),
      ],
        )));
  }

  Future<void> editExercise(BuildContext context, Day day, Exercise exercise) {
    print(exercise.name);

    return showDialog(
        context: context,
        builder: (context) {
          return ExerciseDialog(day, exercise);
        });
  }

  Future<void> deleteExercise(
      BuildContext context, Day day, Exercise exercise) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Exercise"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Are you sure to delete"),
                  Text("${exercise.name}?", style: AppStyles.boldStyle),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  context.read<WorkoutModel>().deleteExercise(day, exercise);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}