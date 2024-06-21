import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/record.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/widgets/Record/record_item.dart';

class RecordPage extends StatelessWidget {
  final List<Record> records;

  const RecordPage({
    super.key,
    required this.records,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutModel>(builder: (_, workout, __) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: AppStyles.floatButtonShape,
            child: const Icon(Icons.add),
          ),
          body: records.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_days_in_list,
                    textAlign: TextAlign.center,
                  ),
                )
              : ReorderableListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) => RecordItem(
                        key: Key('$index'),
                        record: records[index],
                      ),
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    context
                        .read<WorkoutModel>()
                        .changeDayOrder(oldIndex, newIndex);
                  }));
    });
  }
}
