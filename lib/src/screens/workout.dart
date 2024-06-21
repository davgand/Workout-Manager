import 'package:flutter/material.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/provider/navigation_provider.dart';
import 'package:workout_manager/src/screens/record_page.dart';
import 'package:workout_manager/src/screens/timer_page.dart';
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
  int currentPageIndex = 0;
  late final List<GlobalKey<NavigatorState>> navigatorKeys;

  List<Destination> allDestinations = <Destination>[
    Destination(0, "Workout", Icons.sports_gymnastics_rounded,
        Icons.sports_gymnastics_rounded),
    Destination(1, "Timer", Icons.timer_outlined, Icons.timer_outlined),
    Destination(2, "Records", Icons.emoji_events, Icons.emoji_events_outlined)
  ];

  @override
  void initState() {
    super.initState();
    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      allDestinations.length,
      (int index) => GlobalKey(),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    allDestinations[0].title = AppLocalizations.of(context)!.workout(1);
    allDestinations[1].title = "Timer";
    allDestinations[2].title = AppLocalizations.of(context)!.records;


    return NavigatorPopHandler(
        onPop: () {
          final NavigatorState navigator =
              navigatorKeys[currentPageIndex].currentState!;
          navigator.pop();
        },
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: allDestinations.map(
              (Destination destination) {
                final int index = destination.index;
                final Widget view = [
                  DayNavigator(
                      navigatorKey: navigatorKeys[0],
                      days: widget.workout.days),
                  TimerPage(),
                  RecordPage(records: widget.workout.records)
                ][index];
                if (index == currentPageIndex) {
                  return Offstage(offstage: false, child: view);
                } else {
                  return Offstage(child: view);
                }
              },
            ).toList(),
            // [
            // DayNavigator(navigatorKey: navigatorKey, days: widget.workout.days),
            //   DaysList(
            //     days: widget.workout.days,
            //   ),
            //   TimerPage()
            // ][currentPageIndex],
          ),
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Palette.lightGray,
            actions: [
              IconButton(
                  onPressed: () => showHelpDialog(context),
                  icon: Icon(Icons.help))
            ],
          ),
          bottomNavigationBar: NavigationBar(
            backgroundColor: Palette.lightGray,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: Theme.of(context).colorScheme.primary,
            selectedIndex: currentPageIndex,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: allDestinations.map(
              (Destination destination) {
                return NavigationDestination(
                    selectedIcon:
                        Icon(destination.selectedIcon, color: Palette.white),
                    icon: Icon(destination.icon),
                    label: destination.title);
              },
            ).toList(),
          ),
        ));
  }

  Future<void> showHelpDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.help_dialog_title),
            content: SingleChildScrollView(
                child: ListBody(children: [
              Text(AppLocalizations.of(context)!.help_dialog_body),
              Text("\n"),
              Text(AppLocalizations.of(context)!.help_dialog_info),
              Text("\n"),
              Text("\n"),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                AppLocalizations.of(context)!.help_dialog_credits,
                style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            ])),
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
}
