import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/cardio.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:workout_manager/src/widgets/Cardio/cardio_edit.dart';
import 'package:workout_manager/src/widgets/breadcrumb.dart';
import 'package:workout_manager/src/widgets/Cardio/cardio_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardioPage extends StatelessWidget {
  final List<Cardio> cardio;
  final Day day;
  final ValueChanged<Cardio>? onTap;

  const CardioPage({
    required this.day,
    required this.cardio,
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
                  builder: (context) => CardioEdit(day),
                ));
          },
          shape: AppStyles.floatButtonShape,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Breadcrumb(
              startPage: day.description,
              endPage: AppLocalizations.of(context)!.cardio),
        ),
        body: cardio.isEmpty
            ? Center(
                child: Text(
                  AppLocalizations.of(context)!.no_exercises_in_list,
                  textAlign: TextAlign.center,
                ),
              )
            : Consumer<WorkoutModel>(builder: (_, workout, __) {
                return ListView.builder(
                    itemCount: cardio.length,
                    itemBuilder: (context, index) => CardioItem(
                          day: day,
                          cardio: cardio[index],
                        ));
              }));
  }
}
