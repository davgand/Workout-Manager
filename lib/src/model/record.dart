import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/model/exercise.dart';

class Record extends Exercise {
  DateTime? date;

  Record({
    required super.id,
    required super.name,
    super.series = AppConstants.emptyValue,
    super.reps = AppConstants.emptyValue,
    super.time = AppConstants.emptyValue,
    super.weight = AppConstants.emptyValue,
    super.notes = AppConstants.emptyValueString,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json['id'],
        name: json['name'],
        date: DateTime.parse(json['date']),
        series: json['series'],
        reps: json['reps'],
        time: json['time'],
        weight: json['weight'],
        notes: json['notes'],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toString(),
      'series': series,
      'reps': reps,
      'time': time,
      'weight': weight,
      'notes': notes,
    };
  }
}
