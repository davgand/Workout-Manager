import 'package:flutter/material.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/widgets/day_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DaysList extends StatelessWidget {
  final List<Day> days;

  const DaysList({
    super.key,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return days.isEmpty
        ? Center(
            child: Text(
              AppLocalizations.of(context).no_days_in_list,
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: days.length,
            itemBuilder: (context, index) => DayItem(
                  day: days[index],
                ));
  }
}
