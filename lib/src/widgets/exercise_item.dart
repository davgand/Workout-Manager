import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/model/workout.dart';

import 'exercise_popup.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;
  final bool listEditing;
  final Day day;

  const ExerciseItem(
      {super.key,
      required this.day,
      required this.exercise,
      required this.listEditing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        if (listEditing)
          Flexible(
              flex: 30,
              child: Row(children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          editExercise(context, day, exercise);
                        },
                        icon: Icon(Icons.edit))
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          deleteExercise(context, day, exercise);
                        },
                        icon: Icon(Icons.delete))
                  ],
                )
              ]))
      ],
    ));
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
                  Text('Are you sure to delete ${exercise.name}?'),
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
