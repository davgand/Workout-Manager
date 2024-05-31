import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/widgets/Exercise/exercise_edit.dart';
import 'package:workout_manager/src/widgets/slidable_action.dart';

class ExerciseItem extends StatelessWidget {
  final Exercise exercise;
  final Day day;

  const ExerciseItem({
    super.key,
    required this.day,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutModel>(builder: (_, workout, __) {
      return Slidable(
          key: Key(day.id.toString()),
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableActionList(
                action: ActionEnum.edit,
                  onPressed: (context) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseEdit(day, exercise),
                      ))
              ),
              SlidableActionList(
                action: ActionEnum.delete,
                onPressed: (context) => deleteExercise(context, day, exercise),
              ),
            ],
          ),
          child: ListTile(
              title: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              style: Theme.of(context).textTheme.titleMedium,
                              exercise.name,
                              textAlign: TextAlign.start,
                            )
                          ])),
                  Expanded(
                      flex: 1,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (exercise.reps == AppConstants.emptyValue)
                              Text(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  "${exercise.series}")
                            else
                              Text(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  "${exercise.series} x ${exercise.reps}"),
                          ])),
                  if (exercise.weight != AppConstants.emptyValue)
                    Expanded(
                        flex: 1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  "${exercise.weight} kg"),
                            ])),
                  if (exercise.rest != AppConstants.emptyValue)
                    Expanded(
                        flex: 1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  "${exercise.rest} s"),
                            ])),
                  if (exercise.time != AppConstants.emptyValue)
                    Expanded(
                        flex: 1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  "${exercise.time} s"),
                            ])),
                ],
              ),
              onTap: () {
                if (exercise.notes.isNotEmpty) {
                  showNotes(context, exercise);
                }
              }));
    });
  }

  Future<void> showNotes(BuildContext context, Exercise exercise) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.notes),
            content: Text(exercise.notes),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> deleteExercise(
      BuildContext context, Day day, Exercise exercise) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.delete_exercise_list_dialog_title,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!
                      .delete_exercise_list_dialog_body(exercise.name)),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  context.read<WorkoutModel>().deleteExercise(day, exercise);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
