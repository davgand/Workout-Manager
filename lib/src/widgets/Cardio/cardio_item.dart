import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/cardio.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/widgets/Cardio/cardio_edit.dart';
import 'package:workout_manager/src/widgets/slidable_action.dart';

class CardioItem extends StatelessWidget {
  final Cardio cardio;
  final Day day;

  const CardioItem({
    super.key,
    required this.day,
    required this.cardio,
  });

  @override
  Widget build(BuildContext context) {
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
                      builder: (context) => CardioEdit(day, cardio),
                    ))
            ),
            SlidableActionList(
              action: ActionEnum.delete,
              onPressed: (context) => deleteCardio(context, day, cardio),
            ),
          ],
        ),
        child: ListTile(
            title: Row(
              children: [
                Expanded(
                    flex: 30,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: Theme.of(context).textTheme.titleMedium,
                            cardio.name,
                            textAlign: TextAlign.start,
                          )
                        ])),
                Expanded(
                    flex: 15,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (cardio.reps != AppConstants.emptyValue &&
                              cardio.series != AppConstants.emptyValue)
                            Text(
                                style: Theme.of(context).textTheme.bodyLarge,
                                "${cardio.series} x ${cardio.reps}")
                          else if (cardio.reps != AppConstants.emptyValue)
                            Text(
                                style: Theme.of(context).textTheme.bodyLarge,
                                "${cardio.reps}")
                          else if (cardio.series != AppConstants.emptyValue)
                            Text(
                                style: Theme.of(context).textTheme.bodyLarge,
                                "${cardio.series}"),
                        ])),
                if (cardio.distance != AppConstants.emptyValue)
                  Expanded(
                      flex: 15,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                style: Theme.of(context).textTheme.bodyLarge,
                                "${cardio.distance} km"),
                          ])),
                if (cardio.time != AppConstants.emptyValue)
                  Expanded(
                      flex: 15,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                style: Theme.of(context).textTheme.bodyLarge,
                                "${cardio.time} min"),
                          ])),
              ],
            ),
            onTap: () {
              if (cardio.notes.isNotEmpty) {
                showNotes(context, cardio);
              }
            }));
  }

  Future<void> showNotes(BuildContext context, Cardio cardio) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.notes),
            content: Text(cardio.notes),
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

  Future<void> deleteCardio(BuildContext context, Day day, Cardio cardio) {
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
                      .delete_exercise_list_dialog_body(cardio.name)),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  context.read<WorkoutModel>().deleteCardio(day, cardio);
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
