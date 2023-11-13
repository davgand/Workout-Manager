import 'package:workout_manager/src/constants/constants.dart';

class Warmup {
  String id;
  int time;
  int reps;
  String description;
  String type;

  Warmup(
      {required this.id,
      required this.description,
      this.type = "",
      this.time = AppConstants.emptyValue,
      this.reps = AppConstants.emptyValue});

  factory Warmup.fromJson(Map<String, dynamic> json) => Warmup(
        id: json['id'],
        description: json['description'],
        type: json['type'],
        reps: json['reps'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'type': type,
      'reps': reps,
      'time': time,
    };
  }
}
