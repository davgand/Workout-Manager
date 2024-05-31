import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/exercise.dart';

class Warmup extends Exercise {
  WarmupType type;

  Warmup({
    required super.id,
    required super.name,
    required this.type,
    required super.series,
    super.reps = AppConstants.emptyValue,
    super.rest = AppConstants.emptyValue,
    super.time = AppConstants.emptyValue,
    super.notes = AppConstants.emptyValueString,
  });

  factory Warmup.fromJson(Map<String, dynamic> json) => Warmup(
        id: json['id'],
        name: json['name'],
        type: WarmupType.values.byName(json['type']),
        series: json['series'],
        reps: json['reps'],
        rest: json['rest'],
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
      'rest': rest,
      'time': time,
      'notes': notes,
    };
  }
}
