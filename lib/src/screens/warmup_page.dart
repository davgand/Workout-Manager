import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/warmup.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/widgets/Warmup/warmup_edit.dart';
import 'package:workout_manager/src/widgets/breadcrumb.dart';
import 'package:workout_manager/src/widgets/Warmup/warmup_item.dart';

class WarmupPage extends StatelessWidget {
  final List<Warmup> warmups;
  final Day day;
  final ValueChanged<Warmup>? onTap;

  const WarmupPage({
    required this.day,
    required this.warmups,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WarmupEdit(day),
                ));
          },
          shape: AppStyles.floatButtonShape,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Breadcrumb(
              startPage: day.description,
              endPage: AppLocalizations.of(context)!.warmup),
        ),
        body: warmups.isEmpty
            ? Center(
                child: Text(
                  AppLocalizations.of(context)!.no_exercises_in_list,
                  textAlign: TextAlign.center,
                ),
              )
            : Consumer<WorkoutModel>(builder: (_, workout, __) {
                var warmupTypes = getTypes();
                return Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: warmupTypes.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => WarmupItem(
                                    day: day,
                                    warmups: warmups
                                        .where((warmup) =>
                                            warmup.type == warmupTypes[index])
                                        .toList(),
                                    type: warmupTypes[index],
                                  )))
                    ]));
              }));
  }

  List<WarmupType> getTypes() {
    List<WarmupType> types = [];
    for (var warmup in warmups) {
      if (!types.contains(warmup.type)) types.add(warmup.type);
    }
    return types;
  }
}
