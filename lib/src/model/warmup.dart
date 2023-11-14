import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/exercise.dart';

class Warmup extends Exercise {
  WarmupType type;

  Warmup({
    required id,
    required name,
    required this.type,
    required series,
    reps = AppConstants.emptyValue,
    time = AppConstants.emptyValue,
    notes = AppConstants.emptyValueString,
  }) : super(id: id, name: name, series: series, reps: reps, notes: notes);

  factory Warmup.fromJson(Map<String, dynamic> json) => Warmup(
        id: json['id'],
        name: json['name'],
        type: WarmupType.values.byName(json['type']),
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
      'type': type.name,
      'series': series,
      'reps': reps,
      'time': time,
      'notes': notes,
    };
  }
}
