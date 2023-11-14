import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/cardio.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardioDialog extends StatefulWidget {
  final Cardio? cardio;
  final Day day;

  CardioDialog(this.day, [this.cardio]);

  @override
  State<CardioDialog> createState() => _CardioDialogState();
}

class _CardioDialogState extends State<CardioDialog> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController seriesController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Cardio? cardio;
  Day day = Day.create(id: "", description: "", exercises: [], cardio: []);
  bool isNew = true;

  @override
  initState() {
    day = widget.day;
    if (widget.cardio != null) {
      isNew = false;
      cardio = widget.cardio;
      descriptionController = TextEditingController()..text = cardio!.name;
      repsController = TextEditingController()
        ..text = cardio!.reps == AppConstants.emptyValue
            ? ""
            : cardio!.reps.toString();
      seriesController = TextEditingController()
        ..text = cardio!.series == AppConstants.emptyValue
            ? ""
            : cardio!.series.toString();
      timeController = TextEditingController()
        ..text = cardio!.time == AppConstants.emptyValue
            ? ""
            : cardio!.time.toString();
      distanceController = TextEditingController()
        ..text = cardio!.distance == AppConstants.emptyValue
            ? ""
            : cardio!.distance.toString();
      notesController = TextEditingController()..text = cardio!.notes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String title =
    //  widget.cardio == null ? "Add new Cardio" : "Edit Cardio";

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(const Radius.circular(10)),
            color: Colors.white,
          ),
          //width: 380,
          height: 400,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Form(
            key: _formKey,
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context).description,
                            ),
                            textInputAction: TextInputAction.next,
                            controller: descriptionController,
                            validator: (value) => validateInput(value),
                          ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context).series),
                              textInputAction: TextInputAction.next,
                              controller: seriesController,
                            ),
                          )),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context).reps),
                              textInputAction: TextInputAction.next,
                              controller: repsController,
                            ),
                          ),
                        ]),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context).distance),
                            textInputAction: TextInputAction.next,
                            controller: distanceController,
                          ),
                        )),
                        Expanded(
                            child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context).time),
                              textInputAction: TextInputAction.next,
                              controller: timeController,
                            ),
                          )
                        ])),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context).notes),
                            controller: notesController,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              saveCardio(context, day);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Palette.blue),
                            ),
                            child: Text(AppLocalizations.of(context).ok),
                          ),
                          ElevatedButton(
                            onPressed: () => {Navigator.of(context).pop()},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Palette.white),
                            ),
                            child: Text(
                              AppLocalizations.of(context).cancel,
                              style: TextStyle(color: Palette.blue),
                            ),
                          ),
                        ],
                      ))
                ]),
          ),
        )));
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    descriptionController.dispose();
    repsController.dispose();
    seriesController.dispose();
    timeController.dispose();
    distanceController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enter_value_message;
    }
    return null;
  }

  void saveCardio(BuildContext context, Day day) {
    if (_formKey.currentState!.validate()) {
      String description = descriptionController.text;
      int reps = int.tryParse(repsController.text) ?? AppConstants.emptyValue;
      int series =
          int.tryParse(seriesController.text) ?? AppConstants.emptyValue;
      int time = int.tryParse(timeController.text) ?? AppConstants.emptyValue;
      int distance =
          int.tryParse(distanceController.text) ?? AppConstants.emptyValue;
      String notes = notesController.text;

      if (isNew) {
        context
            .read<WorkoutModel>()
            .addCardio(day, description, series, reps, time, distance, notes);
      } else {
        context.read<WorkoutModel>().editCardio(
            day, cardio!, description, series, reps, time, distance, notes);
      }
      Navigator.of(context).pop();
    }
  }
}
