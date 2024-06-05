import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/constants/enum_utilities.dart';
import 'package:workout_manager/src/constants/enums.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/warmup.dart';
import 'package:workout_manager/src/model/workout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/widgets/breadcrumb.dart';

class WarmupEdit extends StatefulWidget {
  final Warmup? warmup;
  final Day day;

  WarmupEdit(this.day, [this.warmup]);

  @override
  State<WarmupEdit> createState() => _WarmupEditState();
}

class _WarmupEditState extends State<WarmupEdit> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController restController = TextEditingController();
  TextEditingController seriesController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  WarmupType type = WarmupType.other;
  final _formKey = GlobalKey<FormState>();
  Warmup? warmup;
  Day day = Day.create(
      id: AppConstants.emptyValueString,
      description: AppConstants.emptyValueString,
      exercises: [],
      warmups: []);
  bool isNew = true;

  @override
  initState() {
    day = widget.day;
    if (widget.warmup != null) {
      isNew = false;
      warmup = widget.warmup;
      descriptionController = TextEditingController()..text = warmup!.name;
      repsController = TextEditingController()
        ..text = warmup!.reps == AppConstants.emptyValue
            ? ""
            : warmup!.reps.toString();
      restController = TextEditingController()
        ..text = warmup!.rest == AppConstants.emptyValue
            ? ""
            : warmup!.rest.toString();
      seriesController = TextEditingController()
        ..text = warmup!.series == AppConstants.emptyValue
            ? ""
            : warmup!.series.toString();
      timeController = TextEditingController()
        ..text = warmup!.time == AppConstants.emptyValue
            ? ""
            : warmup!.time.toString();
      notesController = TextEditingController()..text = warmup!.notes;
      type = warmup!.type;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Breadcrumb(
              startPage: day.description,
              endPage: isNew
                  ? AppLocalizations.of(context)!.add_new_exercise
                  : AppLocalizations.of(context)!.edit_exercise),
        ),
        body: Consumer<WorkoutModel>(builder: (_, workout, __) {
          return Form(
              key: _formKey,
              child: Column(children: [
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
                                  labelText:
                                      AppLocalizations.of(context)!.description,
                                ),
                                textInputAction: TextInputAction.next,
                                controller: descriptionController,
                                validator: (value) => validateInput(value),
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: DropdownButtonFormField(
                                value: WarmupTypeHelper.toValue(type, context),
                                items: WarmupType.values
                                    .map<DropdownMenuItem<String>>((type) {
                                  return DropdownMenuItem<String>(
                                    value:
                                        WarmupTypeHelper.toValue(type, context),
                                    child: Text(
                                      WarmupTypeHelper.toValue(type, context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  );
                                }).toList(),
                                validator: (value) => validateInput(value),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    type = newValue != null
                                        ? WarmupTypeHelper.toEnum(
                                            newValue, context)
                                        : WarmupType.other;
                                  });
                                },
                              ),
                            ),
                          )
                        ]),
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
                                          AppLocalizations.of(context)!.series),
                                  textInputAction: TextInputAction.next,
                                  controller: seriesController,
                                  validator: (value) => validateInput(value),
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
                                          AppLocalizations.of(context)!.reps),
                                  textInputAction: TextInputAction.next,
                                  controller: repsController,
                                ),
                              ),
                            ]),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context)!.rest),
                                textInputAction: TextInputAction.next,
                                controller: restController,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context)!.time),
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
                                        AppLocalizations.of(context)!.notes),
                                controller: notesController,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ])),
                Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FilledButton(
                          onPressed: () {
                            saveWarmup(context, day);
                          },
                          child: Text(AppLocalizations.of(context)!.ok),
                        ),
                        OutlinedButton(
                          onPressed: () => {Navigator.of(context).pop()},
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
    restController.dispose();
    seriesController.dispose();
    timeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enter_value_message;
    }
    return null;
  }

  void saveWarmup(BuildContext context, Day day) {
    if (_formKey.currentState!.validate()) {
      String description = descriptionController.text;
      int reps = int.tryParse(repsController.text) ?? AppConstants.emptyValue;
      int rest = int.tryParse(restController.text) ?? AppConstants.emptyValue;
      int series =
          int.tryParse(seriesController.text) ?? AppConstants.emptyValue;
      int time = int.tryParse(timeController.text) ?? AppConstants.emptyValue;
      String notes = notesController.text;

      if (isNew) {
        context
            .read<WorkoutModel>()
            .addWarmup(day, description, type, series, reps, rest, time, notes);
      } else {
        context.read<WorkoutModel>().editWarmup(
            day, warmup!, description, type, series, reps, rest, time, notes);
      }
      Navigator.of(context).pop();
    }
  }
}
