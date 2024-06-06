import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/screens/cardio_page.dart';
import 'package:workout_manager/src/screens/exercise_page.dart';
import 'package:workout_manager/src/screens/warmup_page.dart';
class DayDetailsPage extends StatefulWidget {
  final Day day;

  DayDetailsPage({
    super.key,
    required this.day,
  });

  static const routeName = '/day';

  @override
  State<DayDetailsPage> createState() => _DayDetailsPageState();
}

class _DayDetailsPageState extends State<DayDetailsPage> {
  Day day = Day.create(id: "", description: "", exercises: []);

  @override
  initState() {
    day = widget.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(day.description),
            )),
      body: Column(children: [
        Expanded(
            flex: 3,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
                  Expanded(
                    child: FloatingActionButton.large(
                      shape: CircleBorder(),
                      backgroundColor: Palette.blue,
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExercisePage(day: day),
                            ))
                      },
                      tooltip: AppLocalizations.of(context)!.exercise_tooltip,
                      child: Icon(
                        Icons.fitness_center_rounded,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ])),
            Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Expanded(
                child: Center(
                    child: IconButton.filledTonal(
                  icon: Icon(
                    Icons.pedal_bike_rounded,
                    color: Palette.blue,
                  ),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CardioPage(day: day, cardio: day.cardio),
                        ))
                  },
                )),
              ),
              Expanded(
                child: Center(
                    child: IconButton.filledTonal(
                  icon: Icon(
                    Icons.thermostat_rounded,
                    color: Palette.blue,
                  ),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WarmupPage(day: day, warmups: day.warmups),
                        ))
                  },
                )),
              ),
              // Expanded(
              //   child: Center(
              //     child: Ink(
              //       decoration: const ShapeDecoration(
              //         color: Palette.blue,
              //         shape: CircleBorder(),
              //       ),
              //       child: IconButton(
              //         tooltip: AppLocalizations.of(context)!.warmup_tooltip,
              //         icon: const Icon(
              //           Icons.thermostat_rounded,
              //           color: Palette.white,
              //         ),
              //         color: Colors.white,
              //         onPressed: () {},
              //       ),
              //     ),
              //   ),
              // ),
            ]))
      ])
      // Expanded(
      //     child: WorkoutTypeItem(
      //         title: AppLocalizations.of(context)!.cardio,
      //         icon: Icons.pedal_bike_sharp,
      //         bgColor: Theme.of(context).colorScheme.secondary,
      //         navigateTo: CardioPage(
      //           day: day,
      //           cardio: day.cardio,
      //         ))),
      // Expanded(
      //     child: WorkoutTypeItem(
      //         title: AppLocalizations.of(context)!.warmup,
      //         icon: Icons.thermostat,
      //         bgColor: Theme.of(context).colorScheme.primary,
      //         navigateTo: WarmupPage(
      //           day: day,
      //           warmups: day.warmups,
      //         ))),
      // Expanded(
      //     child: WorkoutTypeItem(
      //         title: AppLocalizations.of(context)!.exercise(2),
      //         icon: Icons.sports_gymnastics_sharp,
      //         bgColor: Theme.of(context).colorScheme.tertiary,
      //         navigateTo: ExercisePage(
      //           day: day,
      //           exercises: day.exercises,
      //         ))),
      ,
    );
  }
}
