import 'package:flutter/material.dart';
import 'package:gym_manager/src/model/exercise.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;

  const ExerciseItem({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(height: 100, child: Center(child: Text(exercise.name))),
    );
  }
}
