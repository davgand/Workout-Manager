import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/widgets/Exercise/exercise_edit.dart';
import 'package:workout_manager/src/widgets/breadcrumb.dart';
import 'package:workout_manager/src/widgets/Exercise/exercise_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExercisePage extends StatelessWidget {
  final List<Exercise> exercises;
  final Day day;
  final ValueChanged<Exercise>? onTap;

  const ExercisePage({
    required this.day,
    required this.exercises,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseEdit(day),
              ),
            );
          },
          shape: AppStyles.floatButtonShape,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Breadcrumb(
              startPage: day.description,
              endPage: AppLocalizations.of(context)!.exercise(2)),
        ),
        body: exercises.isEmpty
            ? Center(
                child: Text(
                  AppLocalizations.of(context)!.no_exercises_in_list,
                  textAlign: TextAlign.center,
                ),
              )
            : Consumer<WorkoutModel>(builder: (_, workout, __) {
                return ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) => ExerciseItem(
                          day: day,
                          exercise: exercises[index],
                        ));
              }));
  }
}
