import 'package:flutter/material.dart';
import 'package:gym_manager/provider/fileHandler.dart';
import 'package:gym_manager/src/model/workout.dart';
import 'package:gym_manager/src/screens/workout.dart';

class WorkoutManagerApp extends StatefulWidget {
  const WorkoutManagerApp({super.key});

  @override
  State<WorkoutManagerApp> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends State<WorkoutManagerApp> {
  late final title = 'Workout Manager';
  WorkoutModel workout = WorkoutModel(days: []);

  @override
  void initState() {
    readWorkout();
    super.initState();
  }

  void readWorkout() async {
    WorkoutModel workout = await FileHandler.readWorkout();
    setState(() {
      this.workout = workout;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: title, home: WorkoutScreen(workout: workout));
  }
}
