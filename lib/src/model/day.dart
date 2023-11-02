import 'exercise.dart';

class Day {
  int id = 0;
  String description = "";
  List<Exercise> exercises = [];

  Day();
  Day.create(
      {required this.id, required this.description, required this.exercises});

  factory Day.fromJson(Map<String, dynamic> json) {
    final exercisesData = json['exercises'] as List<dynamic>?;
    return Day.create(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }
}
