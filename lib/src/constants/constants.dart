import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';

class AppConstants {
  static const fileName = "workout.json";

  static const emptyValue = 0;

  static List<Day> dummyDays = [
    Day.create(id: 0, description: "Day 1", exercises: [
      Exercise(id: 0, name: "Exercise 1", series: 3, reps: 20, weight: 2000)
    ])
  ];
}
