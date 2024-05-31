import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/model/exercise.dart';

class Cardio extends Exercise {
  int distance;

  Cardio({
    required super.id,
    required super.name,
    this.distance = AppConstants.emptyValue,
    super.series = AppConstants.emptyValue,
    super.reps = AppConstants.emptyValue,
    super.time = AppConstants.emptyValue,
    super.notes = AppConstants.emptyValueString,
  });

  factory Cardio.fromJson(Map<String, dynamic> json) => Cardio(
        id: json['id'],
        name: json['name'],
        distance: json['distance'],
        series: json['series'],
        reps: json['reps'],
        time: json['time'],
        notes: json['notes'],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'distance': distance,
      'series': series,
      'reps': reps,
      'time': time,
      'notes': notes,
    };
  }
}
