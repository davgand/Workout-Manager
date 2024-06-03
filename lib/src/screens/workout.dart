import 'package:flutter/material.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/screens/timer_page.dart';
import 'package:workout_manager/src/widgets/Day/days_list.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Palette.lightGray,
        actions: [
          IconButton(
              onPressed: () => showHelpDialog(context), icon: Icon(Icons.help))
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
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Palette.white),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
              selectedIcon: Icon(Icons.timer_outlined, color: Palette.white),
              icon: Icon(Icons.timer_outlined),
              label: "Timer"),
          // NavigationDestination(
          //   icon: Badge(
          //     label: Text('2'),
          //     child: Badge(child:Icon(Icons.messenger_sharp)),
          //   ),
          //   label: 'Messages',
          // ),
        ],
      ),
      body: [
        DaysList(
        days: widget.workout.days,
        ),
        TimerPage()
      ][currentPageIndex],
    );
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
              Text(
                AppLocalizations.of(context)!.help_dialog_credits,
                style: Theme.of(context).textTheme.bodySmall,
              ),
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
