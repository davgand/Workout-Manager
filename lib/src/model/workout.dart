import 'package:flutter/foundation.dart';
import 'package:workout_manager/src/provider/fileHandler.dart';
import 'package:workout_manager/src/model/exercise.dart';

import 'day.dart';

class WorkoutModel extends ChangeNotifier {
  List<Day> days = [];

  WorkoutModel(this.days);

  WorkoutModel.create() {
    create();
  }

  Future<void> create() async {
    final workout = await FileHandler.readWorkout();
    days = workout.days;
    notifyListeners();
  }

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    final daysData = json['days'] as List<dynamic>?;
    return WorkoutModel(
      daysData != null
          ? daysData
              .map((day) => Day.fromJson(day as Map<String, dynamic>))
              .toList()
          : <Day>[],
    );
  }

  Map<String, dynamic> toJson() =>
      {'days': days.map((day) => day.toJson()).toList()};

// Adds a workout day to the list
  void addDay({
    required String description,
    List<Exercise>? exercises,
  }) {
    var day = Day.create(
        id: days.length, description: description, exercises: exercises ?? []);
    days.add(day);

    FileHandler.writeWorkout(WorkoutModel(days));

    notifyListeners();
  }

  void editDay({
    required int id,
    required String description,
  }) {
    days[id].description = description;

    FileHandler.writeWorkout(WorkoutModel(days));

    notifyListeners();
  }

  Day getDayById(int id) {
    return days.elementAt(id);
  }

  void deleteDay(Day day) {
    days.removeAt(day.id);

    FileHandler.writeWorkout(WorkoutModel(days));

    notifyListeners();
  }

  void addExercise(Day day, String name, int reps, int weight,
      [String notes = ""]) {
    var exercise = Exercise(
        id: days[day.id].exercises.length,
        name: name,
        reps: reps,
        weight: weight,
        notes: notes);
    days[day.id].exercises.add(exercise);

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void editExercise(Day day, int id, String name, int reps, int weight,
      [String notes = ""]) {
    days[day.id].exercises[id].name = name;
    days[day.id].exercises[id].reps = reps;
    days[day.id].exercises[id].weight = weight;
    days[day.id].exercises[id].notes = notes;

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void deleteExercise(Day day, Exercise exercise) {
    days[day.id].exercises.remove(exercise);

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  Exercise getExerciseById(Day day, int id) {
    var result = Exercise(
        id: id,
        name: days[day.id].exercises[id].name,
        reps: days[day.id].exercises[id].reps,
        weight: days[day.id].exercises[id].weight,
        notes: days[day.id].exercises[id].notes);
    return result;
  }
}
