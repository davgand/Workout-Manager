import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/cardio.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/model/warmup.dart';
import 'package:workout_manager/src/provider/fileHandler.dart';

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
    var uuid = Uuid();

    var day = Day.create(
        id: uuid.v1(), description: description, exercises: exercises ?? []);
    days.add(day);

    FileHandler.writeWorkout(WorkoutModel(days));

    notifyListeners();
  }

  void editDay({
    required Day day,
    required String description,
  }) {
    var dayId = days.indexOf(day);
    days[dayId].description = description;

    FileHandler.writeWorkout(WorkoutModel(days));

    notifyListeners();
  }

  Day getDayById(String id) {
    return days.where((day) => day.id == id).first;
  }

  void deleteDay(Day dayToDelete) {
    days.removeWhere((day) => day.id == dayToDelete.id);

    FileHandler.writeWorkout(WorkoutModel(days));

    notifyListeners();
  }

  void changeDayOrder(int oldIndex, int newIndex) {
    final Day item = days.removeAt(oldIndex);
    days.insert(newIndex, item);
    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void addExercise(Day day, String name, int series,
      [int reps = 0,
      int rest = 0,
      int time = 0,
      int weight = 0,
      String notes = ""]) {
    var uuid = Uuid();

    var exercise = Exercise(
        id: uuid.v1(),
        name: name,
        reps: reps,
        rest: rest,
        series: series,
        time: time,
        weight: weight,
        notes: notes);

    days[days.indexOf(day)].exercises.add(exercise);

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void editExercise(Day day, Exercise exercise, String name, int series,
      [int reps = 0,
      int rest = 0,
      int time = 0,
      int weight = 0,
      String notes = ""]) {
    var dayIndex = days.indexOf(day);
    var index = days[dayIndex].exercises.indexOf(exercise);
    days[dayIndex].exercises[index].name = name;
    days[dayIndex].exercises[index].reps = reps;
    days[dayIndex].exercises[index].rest = rest;
    days[dayIndex].exercises[index].series = series;
    days[dayIndex].exercises[index].time = series;
    days[dayIndex].exercises[index].weight = weight;
    days[dayIndex].exercises[index].notes = notes;

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void deleteExercise(Day day, Exercise exercise) {
    days[days.indexOf(day)].exercises.remove(exercise);

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  Exercise getExerciseById(Day day, String id) {
    var dayIndex = days.indexOf(day);
    var exerciseIndex =
        days[dayIndex].exercises.indexWhere((exercise) => exercise.id == id);
    var result = Exercise(
        id: id,
        name: days[dayIndex].exercises[exerciseIndex].name,
        reps: days[dayIndex].exercises[exerciseIndex].reps,
        rest: days[dayIndex].exercises[exerciseIndex].rest,
        series: days[dayIndex].exercises[exerciseIndex].series,
        time: days[dayIndex].exercises[exerciseIndex].time,
        weight: days[dayIndex].exercises[exerciseIndex].weight,
        notes: days[dayIndex].exercises[exerciseIndex].notes);
    return result;
  }

  void addWarmup(Day day, String name, WarmupType type, int series,
      [int reps = 0, int rest = 0, int time = 0, String notes = ""]) {
    var uuid = Uuid();

    var warmup = Warmup(
        id: uuid.v1(),
        name: name,
        type: type,
        reps: reps,
        rest: rest,
        series: series,
        time: time,
        notes: notes);

    days[days.indexOf(day)].warmups.add(warmup);

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void editWarmup(
      Day day, Warmup warmup, String name, WarmupType type, int series,
      [int reps = 0, int rest = 0, int time = 0, String notes = ""]) {
    var dayIndex = days.indexOf(day);
    var index = days[dayIndex].warmups.indexOf(warmup);
    days[dayIndex].warmups[index].name = name;
    days[dayIndex].warmups[index].reps = reps;
    days[dayIndex].warmups[index].rest = rest;
    days[dayIndex].warmups[index].type = type;
    days[dayIndex].warmups[index].series = series;
    days[dayIndex].warmups[index].time = series;
    days[dayIndex].warmups[index].notes = notes;

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void deleteWarmup(Day day, Warmup warmup) {
    days[days.indexOf(day)].warmups.remove(warmup);

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void addCardio(Day day, String name,
      [int series = 0,
      int reps = 0,
      int time = 0,
      int distance = 0,
      String notes = ""]) {
    var uuid = Uuid();

    var cardio = Cardio(
        id: uuid.v1(),
        name: name,
        distance: distance,
        reps: reps,
        series: series,
        time: time,
        notes: notes);

    days[days.indexOf(day)].cardio.add(cardio);

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void editCardio(Day day, Cardio cardio, String name,
      [int series = 0,
      int reps = 0,
      int time = 0,
      int distance = 0,
      String notes = ""]) {
    var dayIndex = days.indexOf(day);
    var index = days[dayIndex].cardio.indexOf(cardio);
    days[dayIndex].cardio[index].name = name;
    days[dayIndex].cardio[index].reps = reps;
    days[dayIndex].cardio[index].distance = distance;
    days[dayIndex].cardio[index].series = series;
    days[dayIndex].cardio[index].time = time;
    days[dayIndex].cardio[index].notes = notes;

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }

  void deleteCardio(Day day, Cardio cardio) {
    days[days.indexOf(day)].cardio.remove(cardio);

    FileHandler.writeWorkout(WorkoutModel(days));
    notifyListeners();
  }
}
