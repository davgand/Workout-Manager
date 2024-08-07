import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';

class AppConstants {
  static const fileName = "workout.json";

  static const emptyValue = 0;
  static const emptyValueString = "";
  static const dateFormat = "dd-MM-yyyy";

  static List<Day> dummyDays = [
    Day.create(id: "day1", description: "Day 1", exercises: [
      Exercise(id: "ex1", name: "Exercise 1", series: 3, reps: 20, weight: 2000)
    ])
  ];

  static const List<String> distanceUnitList = <String>["m", "Km"];
  static const List<String> timeUnitList = <String>["s", "min"];
}
