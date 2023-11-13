import 'package:workout_manager/src/constants/constants.dart';

class Exercise {
  String id;
  String name;
  int reps;
  int series;
  int time;
  int weight;
  String notes;

  Exercise(
      {required this.id,
      required this.name,
      this.reps = AppConstants.emptyValue,
      required this.series,
      this.time = AppConstants.emptyValue,
      this.weight = AppConstants.emptyValue,
      this.notes = ""});

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'],
        name: json['name'],
        reps: json['reps'],
        series: json['series'],
        time: json['time'],
        weight: json['weight'],
        notes: json['notes'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'reps': reps,
      'series': series,
      'time': time,
      'weight': weight,
      'notes': notes,
    };
  }
}
