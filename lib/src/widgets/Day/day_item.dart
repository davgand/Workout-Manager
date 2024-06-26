import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/screens/day_details_page.dart';
import 'package:workout_manager/src/widgets/Day/day_popup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/widgets/slidable_action.dart';

class DayItem extends StatelessWidget {
  final Day day;

  const DayItem({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: Key(day.id.toString()),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          //dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableActionList(
              action: ActionEnum.edit,
              onPressed: (context) => editDay(context, day),
            ),
            SlidableActionList(
              action: ActionEnum.delete,
              onPressed: (context) => deleteDay(context, day),
            ),
          ],
        ),
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(day.description,
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, DayDetailsPage.routeName,
                arguments: day);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DayDetailsPage(day: day),
            //   ),
            // );
          },
          minVerticalPadding: 50,
          titleAlignment: ListTileTitleAlignment.center,
        ));
  }

  Future<void> editDay(BuildContext context, Day day) {
    return showDialog(
        context: context,
        builder: (context) {
          return DayDialog(day);
        });
  }

  Future<void> deleteDay(BuildContext context, Day day) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                AppLocalizations.of(context)!.delete_day_list_dialog_title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!
                      .delete_day_list_dialog_body(day.description)),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  context.read<WorkoutModel>().deleteDay(day);
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
