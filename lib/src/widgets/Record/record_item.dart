import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/model/record.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/widgets/Record/record_edit.dart';
import 'package:workout_manager/src/widgets/slidable_action.dart';

class RecordItem extends StatelessWidget {
  final Record record;

  const RecordItem({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutModel>(builder: (_, workout, __) {
      return Slidable(
          key: Key(record.id.toString()),
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableActionList(
                  action: ActionEnum.edit,
                  onPressed: (context) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecordEdit(record),
                      ))),
              SlidableActionList(
                action: ActionEnum.delete,
                onPressed: (context) => deleteRecord(context, record),
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
                              record.name,
                              textAlign: TextAlign.start,
                            )
                          ])),
                  Expanded(
                      flex: 1,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (record.series != AppConstants.emptyValue &&
                                record.reps != AppConstants.emptyValue)
                              Text(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  "${record.series} x ${record.reps}")
                            else
                            if (record.reps != AppConstants.emptyValue)
                              Text(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  "${record.reps}"),
                            if (record.series != AppConstants.emptyValue)
                              Text(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  "${record.series}")
                          ])),
                  if (record.weight != AppConstants.emptyValue)
                    Expanded(
                        flex: 1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  "${record.weight} kg"),
                            ])),
                  if (record.time != AppConstants.emptyValue)
                    Expanded(
                        flex: 1,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  "${record.time} s"),
                            ])),
                ],
              ),
              onTap: () {
                if (record.notes.isNotEmpty) {
                  showNotes(context, record);
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

  Future<void> deleteRecord(BuildContext context, Record record) {
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
                      .delete_exercise_list_dialog_body(record.name)),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  context.read<WorkoutModel>().deleteRecord(record);
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
