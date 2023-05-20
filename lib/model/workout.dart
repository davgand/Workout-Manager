import 'package:flutter/material.dart';
import 'day.dart';

class WorkoutModel extends ChangeNotifier {
  final List<Day> _days = [];

// Adds a workout day to the list
  void add(Day day) {
    _days.add(day);
    notifyListeners();
  }

  Day getDayById(int id) {
    var result = Day(id, _days[id].description, _days[id].exercises);
    return result;
  }

  void remove(Day day) {
    _days.remove(day);
    notifyListeners();
  }
}
