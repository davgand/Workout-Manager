import 'package:flutter/material.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/widgets/day_popup.dart';
import 'package:workout_manager/src/widgets/days_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkoutScreen extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutScreen({super.key, required this.workout});
  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final String title = 'Workout Manager';
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayDayDialog(context);
        },
        shape: AppStyles.floatButtonShape,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () => showHelpDialog(context), icon: Icon(Icons.help))
        ],
      ),
      body: DaysList(
        days: widget.workout.days,
      ),
    );
  }

  Future<void> displayDayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return DayDialog();
        });
  }

  Future<void> showHelpDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).help_dialog_title),
            content: SingleChildScrollView(
                child: ListBody(children: [
              Text(AppLocalizations.of(context).help_dialog_body),
              Text("\n"),
              Text(AppLocalizations.of(context).help_dialog_info),
              Text("\n"),
              Text("\n"),
              Text(
                AppLocalizations.of(context).help_dialog_credits,
                style: AppStyles.smallStyle,
              ),
            ])),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context).ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
