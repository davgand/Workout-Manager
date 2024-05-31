import 'package:workout_manager/src/constants/constants.dart';

class Exercise {
  String id;
  String name;
  int reps;
  int series;
  int rest;
  int time;
  int weight;
  String notes;

  Exercise(
      {required this.id,
      required this.name,
      this.reps = AppConstants.emptyValue,
      required this.series,
      this.rest = AppConstants.emptyValue,
      this.time = AppConstants.emptyValue,
      this.weight = AppConstants.emptyValue,
      this.notes = AppConstants.emptyValueString});

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'],
        name: json['name'],
        reps: json['reps'],
        series: json['series'],
        rest: json['rest'],
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
      'rest': rest,
      'time': time,
      'weight': weight,
      'notes': notes,
    };
  }
}
