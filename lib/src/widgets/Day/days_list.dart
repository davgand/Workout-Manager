import 'package:flutter/material.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/widgets/Day/day_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/widgets/Day/day_popup.dart';

class DaysList extends StatelessWidget {
  final List<Day> days;

  const DaysList({
    super.key,
    required this.days,
  });

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
        body: days.isEmpty
        ? Center(
            child: Text(
              AppLocalizations.of(context)!.no_days_in_list,
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: days.length,
            itemBuilder: (context, index) => DayItem(
                  day: days[index],
                    )));
  }
}

Future<void> displayDayDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return DayDialog();
      });
}
