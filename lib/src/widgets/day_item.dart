import 'package:flutter/material.dart';
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
    return ListTile(
      title: Text(day.description, style: AppStyles.textListStyle),
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
      trailing: IconButton(
          onPressed: () {
            editDay(context, day);
          },
          icon: Icon(Icons.edit, size: 24)),
    );
  }

  Future<void> editDay(BuildContext context, Day day) {
    return showDialog(
        context: context,
        builder: (context) {
          return DayDialog(day);
        });
  }

  void deleteDay(int id) {}
}
