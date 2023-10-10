import 'package:gym_manager/src/model/exercise.dart';

import 'day.dart';

final workoutInstance = WorkoutModel()
  ..addDay(description: "prova")
  ..addDay(description: "prova2");

class WorkoutModel {
  // extends ChangeNotifier {
  final List<Day> days = [];

// Adds a workout day to the list
  void addDay({
    required String description,
    List<Exercise>? exercises,
  }) {
    var day = Day(days.length.toString(), description);
    day.exercises = exercises ?? [];
    days.add(day);
    //notifyListeners();
  }

  //Day getDayById(String id) {
  // var result = Day(id, days[id].description);
  // return result;
  //}

  void remove(Day day) {
    days.remove(day);
    //notifyListeners();
  }
}
