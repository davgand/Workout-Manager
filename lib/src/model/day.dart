import 'package:workout_manager/src/model/cardio.dart';
import 'package:workout_manager/src/model/warmup.dart';

import 'exercise.dart';

class Day {
  String id;
  String description;
  List<Exercise> exercises;
  List<Warmup> warmups;
  List<Cardio> cardio;

  // Day();
  Day.create(
      {required this.id,
      required this.description,
      required this.exercises,
    this.warmups = const [],
    this.cardio = const [],
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    final exercisesData = json['exercises'] as List<dynamic>?;
    final warmupsData = json['warmups'] as List<dynamic>?;
    final cardioData = json['cardio'] as List<dynamic>?;
    return Day.create(
        id: json['id'],
        description: json['description'],
        exercises: exercisesData != null
            ? exercisesData
                .map((exercise) =>
                    Exercise.fromJson(exercise as Map<String, dynamic>))
                .toList()
            : <Exercise>[],
        warmups: warmupsData != null
            ? warmupsData
                .map(
                    (warmup) => Warmup.fromJson(warmup as Map<String, dynamic>))
                .toList()
            : <Warmup>[],
        cardio: cardioData != null
            ? cardioData
                .map(
                    (cardio) => Cardio.fromJson(cardio as Map<String, dynamic>))
                .toList()
            : <Cardio>[]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
      'warmups': warmups.map((warmup) => warmup.toJson()).toList(),
      'cardio': cardio.map((cardio) => cardio.toJson()).toList(),
    };
  }
}
