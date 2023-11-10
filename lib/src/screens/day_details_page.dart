import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/screens/exercise_page.dart';
import 'package:workout_manager/src/widgets/workout_type_item.dart';

class DayDetailsPage extends StatefulWidget {
  final Day day;

  DayDetailsPage({
    super.key,
    required this.day,
  });

  @override
  State<DayDetailsPage> createState() => _DayDetailsPageState();
}

class _DayDetailsPageState extends State<DayDetailsPage> {
  Day day = Day.create(id: 0, description: "", exercises: []);

  @override
  initState() {
    day = widget.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(day.description),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: WorkoutTypeItem(
                    title: AppLocalizations.of(context).cardio,
                    icon: Icons.pedal_bike_sharp,
                    bgColor: Palette.lightBlue,
                    navigateTo: ExercisePage(
                      day: day,
                      exercises: day.exercises,
                    ))),
            Expanded(
                child: WorkoutTypeItem(
                    title: AppLocalizations.of(context).warmup,
                    icon: Icons.thermostat,
                    bgColor: Palette.blue,
                    navigateTo: ExercisePage(
                      day: day,
                      exercises: day.exercises,
                    ))),
            Expanded(
                child: WorkoutTypeItem(
                    title: AppLocalizations.of(context).exercise(2),
                    icon: Icons.sports_gymnastics_sharp,
                    bgColor: Palette.darkBlue,
                    navigateTo: ExercisePage(
                      day: day,
                      exercises: day.exercises,
                    ))),
          ],
        ));
  }
}
