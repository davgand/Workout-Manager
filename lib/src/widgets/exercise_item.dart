import 'package:flutter/material.dart';
import 'package:gym_manager/src/constants/app_styles.dart';
import 'package:gym_manager/src/model/exercise.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;

  const ExerciseItem({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
            child: Column(children: [
          Text(style: AppStyles.exerciseTitleStyle, exercise.name)
        ])),
        Expanded(
            child: Column(children: [
          Text(exercise.reps.toString()),
        ])),
        Expanded(
            child: Column(children: [
          Text("${exercise.weight} kg"),
        ]))
      ],
    ));
  }
}
