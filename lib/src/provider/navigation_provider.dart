import 'package:flutter/material.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/screens/day_details_page.dart';
import 'package:workout_manager/src/widgets/Day/days_list.dart';

class Destination {
  const Destination(this.index, this.title, this.selectedIcon, this.icon);
  final int index;
  final String title;
  final IconData selectedIcon;
  final IconData icon;
}

class DayNavigator extends StatefulWidget {
  const DayNavigator(
      {super.key, required this.navigatorKey, required this.days});

  final Key navigatorKey;
  final List<Day> days;
  @override
  State<DayNavigator> createState() => _DayNavigatorState();
}

class _DayNavigatorState extends State<DayNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: DaysList.routeName,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case DaysList.routeName:
                return DaysList(days: widget.days);
              case DayDetailsPage.routeName:
                return DayDetailsPage(day: settings.arguments as Day);
            }
            assert(false);
            return const Text("Error!");
          },
        );
      },
    );
  }
}
