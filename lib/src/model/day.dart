import "package:json_annotation/json_annotation.dart";

import 'exercise.dart';

@JsonSerializable()
class Day {
  final String id;
  String description;
  List<Exercise> exercises = <Exercise>[];

  Day(this.id, this.description);

  void addExercise({
    required String name,
    required int rep,
    required int weight,
  }) {
    var exercise = Exercise(exercises.length, name, rep, weight);
    exercises.add(exercise);
  }

  Exercise getExerciseById(int id) {
    var result = Exercise(
        id, exercises[id].name, exercises[id].reps, exercises[id].weight);
    return result;
  }
}
