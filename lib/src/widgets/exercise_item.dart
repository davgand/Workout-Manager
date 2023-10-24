import 'package:flutter/material.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/exercise.dart';

import 'exercise_popup.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;
  final bool listEditing;

  const ExerciseItem(
      {super.key, required this.exercise, required this.listEditing});

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
                          editExercise(context, exercise);
                        },
                        icon: Icon(Icons.edit))
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          deleteExercise(exercise.id);
                        },
                        icon: Icon(Icons.delete))
                  ],
                )
              ]))
      ],
    ));
  }

  Future<void> editExercise(BuildContext context, Exercise exercise) {
    print(exercise.name);

    return showDialog(
        context: context,
        builder: (context) {
          return ExerciseDialog(exercise);
        });
  }

  void deleteExercise(int id) {}
}
