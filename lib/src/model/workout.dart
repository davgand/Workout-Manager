import 'package:flutter/foundation.dart';
import 'package:gym_manager/src/model/exercise.dart';

import 'day.dart';

class WorkoutModel extends ChangeNotifier {
  List<Day> days;

  WorkoutModel({required this.days});

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    final daysData = json['days'] as List<dynamic>?;
    return WorkoutModel(
      days: daysData != null
          ? daysData
              .map((day) => Day.fromJson(day as Map<String, dynamic>))
              .toList()
          : <Day>[],
    );
  }

  Map<String, dynamic> toJson() => {'days': days};

// Adds a workout day to the list
  void addDay({
    required String description,
    List<Exercise>? exercises,
  }) {
    var day = Day(id: days.length, description: description, exercises: []);
    day.exercises = exercises ?? [];
    days.add(day);
    notifyListeners();
  }

  Day getDayById(int id) {
    var result = Day(
        id: id,
        description: days[id].description,
        exercises: days[id].exercises);
    return result;
  }

  void remove(Day day) {
    days.remove(day);
    notifyListeners();
  }
}
