import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/screens/day_details_screen.dart';
import 'package:workout_manager/src/widgets/day_popup.dart';

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
            SlidableAction(
              onPressed: (context) => editDay(context, day),
              backgroundColor: Palette.white,
              foregroundColor: Palette.grey,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (context) => deleteDay(context, day),
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
                child: Text(day.description, style: AppStyles.dayListStyle),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DayDetailsScreen(day: day),
              ),
            );
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
            title: const Text("Delete Exercise"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Are you sure to delete"),
                  Text("${day.description}? \n", style: AppStyles.boldStyle),
                  Text("All exercises associated will be deleted.")
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  context.read<WorkoutModel>().deleteDay(day);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}