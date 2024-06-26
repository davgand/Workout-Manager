import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/widgets/Day/day_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/widgets/Day/day_popup.dart';

class DaysList extends StatelessWidget {
  final List<Day> days;

  const DaysList({
    super.key,
    required this.days,
  });

  static const routeName = '/';


  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutModel>(builder: (_, workout, __) {
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
              : ReorderableListView.builder(
                  itemCount: days.length,
                  itemBuilder: (context, index) => DayItem(
                        key: Key('$index'),
                        day: days[index],
                      ),
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    context
                        .read<WorkoutModel>()
                        .changeDayOrder(oldIndex, newIndex);
                  }
                  ));
    });
  }

  Future<void> displayDayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return DayDialog();
        });
  }
}
