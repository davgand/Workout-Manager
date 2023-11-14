import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/screens/workout.dart';

class WorkoutManagerApp extends StatefulWidget {
  const WorkoutManagerApp({super.key});

  @override
  State<WorkoutManagerApp> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends State<WorkoutManagerApp> {
  final title = 'Workout Manager';

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
              title: title,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              home: WorkoutScreen(workout: workout));
        }));
  }
}
