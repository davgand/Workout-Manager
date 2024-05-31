import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/constants/enum_utilities.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/warmup.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/widgets/Warmup/warmup_edit.dart';

class WarmupItem extends StatelessWidget {
  final List<Warmup> warmups;
  final WarmupType type;
  final Day day;

  const WarmupItem(
      {super.key,
      required this.day,
      required this.warmups,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutModel>(builder: (_, workout, __) {
      return Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Column(children: [
            Text(
              WarmupTypeHelper.toValue(type, context),
              style: AppStyles.exerciseTitleStyle,
            ),
            ListView.builder(
                itemCount: warmups.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Slidable(
                    key: Key(day.id.toString()),
                    startActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WarmupEdit(day, warmups[index]),
                              )),
                          backgroundColor: Palette.white,
                          foregroundColor: Palette.grey,
                          icon: Icons.edit,
                        ),
                        SlidableAction(
                          onPressed: (context) =>
                              deleteWarmup(context, day, warmups[index]),
                          backgroundColor: Palette.red,
                          foregroundColor: Palette.white,
                          icon: Icons.delete,
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
                                      style: AppStyles.exerciseTitleStyle,
                                      warmups[index].name,
                                      textAlign: TextAlign.start,
                                    )
                                  ])),
                          Expanded(
                              flex: 1,
                              child: Column(children: [
                                if (warmups[index].reps ==
                                    AppConstants.emptyValue)
                                  Text("${warmups[index].series}")
                                else
                                  Text(
                                      "${warmups[index].series} x ${warmups[index].reps}"),
                              ])),
                          if (warmups[index].time != AppConstants.emptyValue)
                            Expanded(
                                flex: 1,
                                child: Column(children: [
                                  Text("${warmups[index].time} s"),
                                ])),
                            // Expanded(
                            //     flex: 2,
                            //     child: Column(children: [
                            //       Text(warmups[index].notes),
                            //     ])),
                        ],
                      ),
                        onTap: () {
                          showNotes(context, warmups[index]);
                        }
                    )))
          ]));
    });
  }

  Future<void> showNotes(BuildContext context, Warmup warmup) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.notes),
            content: Text(warmup.notes),
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

  Future<void> deleteWarmup(BuildContext context, Day day, Warmup warmup) {
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
                      .delete_exercise_list_dialog_body(warmup.name)),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  context.read<WorkoutModel>().deleteWarmup(day, warmup);
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
