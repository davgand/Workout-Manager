import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/widgets/breadcrumb.dart';

class ExerciseEdit extends StatefulWidget {
  final Exercise? exercise;
  final Day day;

  ExerciseEdit(this.day, [this.exercise]);

  @override
  State<ExerciseEdit> createState() => _ExerciseEditState();
}

class _ExerciseEditState extends State<ExerciseEdit> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController seriesController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Exercise? exercise;
  Day day = Day.create(id: "", description: "", exercises: []);
  bool isNew = true;

  @override
  initState() {
    day = widget.day;
    if (widget.exercise != null) {
      isNew = false;
      exercise = widget.exercise;
      descriptionController = TextEditingController()..text = exercise!.name;
      repsController = TextEditingController()
        ..text = exercise!.reps == AppConstants.emptyValue
            ? ""
            : exercise!.reps.toString();
      seriesController = TextEditingController()
        ..text = exercise!.series == AppConstants.emptyValue
            ? ""
            : exercise!.series.toString();
      timeController = TextEditingController()
        ..text = exercise!.time == AppConstants.emptyValue
            ? ""
            : exercise!.time.toString();
      weightController = TextEditingController()
        ..text = exercise!.weight == AppConstants.emptyValue
            ? ""
            : exercise!.weight.toString();
      notesController = TextEditingController()..text = exercise!.notes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Breadcrumb(
              startPage: day.description,
              endPage: isNew
                  ? AppLocalizations.of(context)!.add_new_exercise
                  : AppLocalizations.of(context)!.edit_exercise),
        ),
        body: Consumer<WorkoutModel>(builder: (_, workout, __) {
          return Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: <Widget>[
                            Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!
                                            .description,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      controller: descriptionController,
                                      validator: (value) =>
                                          validateInput(value),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                AppLocalizations.of(context)!
                                                    .series),
                                        textInputAction: TextInputAction.next,
                                        controller: seriesController,
                                        validator: (value) =>
                                            validateInput(value),
                                      ),
                                    )),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .reps),
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
                                              AppLocalizations.of(context)!
                                                  .weight),
                                      textInputAction: TextInputAction.next,
                                      controller: weightController,
                                    ),
                                  )),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .time),
                                      textInputAction: TextInputAction.next,
                                      controller: timeController,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .notes),
                                      controller: notesController,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ]),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                saveExercise(context, day);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Palette.blue),
                              ),
                              child: Text(AppLocalizations.of(context)!.ok),
                            ),
                            ElevatedButton(
                              onPressed: () => {Navigator.of(context).pop()},
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStateProperty.all(Palette.white),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                style: TextStyle(color: Palette.blue),
                              ),
                            ),
                          ],
                        ))
                  ]));
        }));
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    descriptionController.dispose();
    repsController.dispose();
    seriesController.dispose();
    timeController.dispose();
    weightController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enter_value_message;
    }
    return null;
  }

  void saveExercise(BuildContext context, Day day) {
    if (_formKey.currentState!.validate()) {
      String description = descriptionController.text;
      int reps = int.tryParse(repsController.text) ?? AppConstants.emptyValue;
      int series =
          int.tryParse(seriesController.text) ?? AppConstants.emptyValue;
      int time = int.tryParse(timeController.text) ?? AppConstants.emptyValue;
      int weight =
          int.tryParse(weightController.text) ?? AppConstants.emptyValue;
      String notes = notesController.text;

      if (isNew) {
        context
            .read<WorkoutModel>()
            .addExercise(day, description, series, reps, time, weight, notes);
      } else {
        context.read<WorkoutModel>().editExercise(
            day, exercise!, description, series, reps, time, weight, notes);
      }
      Navigator.of(context).pop();
    }
  }
}
