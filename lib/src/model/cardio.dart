import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/model/exercise.dart';

class Cardio extends Exercise {
  int distance;

  Cardio({
    required id,
    required name,
    this.distance = AppConstants.emptyValue,
    series = AppConstants.emptyValue,
    reps = AppConstants.emptyValue,
    time = AppConstants.emptyValue,
    notes = AppConstants.emptyValueString,
  }) : super(
            id: id,
            name: name,
            series: series,
            reps: reps,
            time: time,
            notes: notes);

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
