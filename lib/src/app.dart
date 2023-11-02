import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/provider/fileHandler.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/screens/workout.dart';

class WorkoutManagerApp extends StatefulWidget {
  const WorkoutManagerApp({super.key});

  @override
  State<WorkoutManagerApp> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends State<WorkoutManagerApp> {
  late final title = 'Workout Manager';

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WorkoutModel.create(),
        child: Consumer<WorkoutModel>(builder: (_, workout, __) {
          return MaterialApp(
              title: title, home: WorkoutScreen(workout: workout));
        }));
  }
}
