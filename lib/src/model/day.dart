import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'exercise.dart';

class Day extends ChangeNotifier {
  final int id;
  String description;
  List<Exercise> exercises;

  Day({required this.id, required this.description, required this.exercises});

  factory Day.fromJson(Map<String, dynamic> json) {
    final exercisesData = json['exercises'] as List<dynamic>?;
    return Day(
      id: json['id'],
      description: json['description'],
      exercises: exercisesData != null
          ? exercisesData
              .map((exercise) =>
                  Exercise.fromJson(exercise as Map<String, dynamic>))
              .toList()
          : <Exercise>[],
    );
  }
  void addExercise({
    required String name,
    required int reps,
    required int weight,
  }) {
    var exercise =
        Exercise(id: exercises.length, name: name, reps: reps, weight: weight);
    exercises.add(exercise);
    notifyListeners();
  }

  void deleteExercise({required Exercise exercise}) {
    exercises.remove(exercise);
    notifyListeners();
  }

  Exercise getExerciseById(int id) {
    var result = Exercise(
        id: id,
        name: exercises[id].name,
        reps: exercises[id].reps,
        weight: exercises[id].weight);
    return result;
  }
}
