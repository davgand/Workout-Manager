import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/constants.dart';
import 'package:workout_manager/src/model/record.dart';
import 'package:workout_manager/src/model/workout.dart';

class RecordEdit extends StatefulWidget {
  final Record? record;

  RecordEdit([this.record]);

  @override
  State<RecordEdit> createState() => _RecordEditState();
}

class _RecordEditState extends State<RecordEdit> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController seriesController = TextEditingController();
  TextEditingController restController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Record? record;
  bool isNew = true;

  @override
  initState() {
    if (widget.record != null) {
      isNew = false;
      record = widget.record;
      descriptionController = TextEditingController()..text = record!.name;
      repsController = TextEditingController()
        ..text = record!.reps == AppConstants.emptyValue
            ? ""
            : record!.reps.toString();
      seriesController = TextEditingController()
        ..text = record!.series == AppConstants.emptyValue
            ? ""
            : record!.series.toString();
      restController = TextEditingController()
        ..text = record!.rest == AppConstants.emptyValue
            ? ""
            : record!.rest.toString();
      timeController = TextEditingController()
        ..text = record!.time == AppConstants.emptyValue
            ? ""
            : record!.time.toString();
      weightController = TextEditingController()
        ..text = record!.weight == AppConstants.emptyValue
            ? ""
            : record!.weight.toString();
      notesController = TextEditingController()..text = record!.notes;
      dateController = TextEditingController()
        ..text =
            "${record!.date?.day}-${record!.date?.month}-${record!.date?.year}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(isNew
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
                                ],
                              ),
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
                                      textInputAction: TextInputAction.next,
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
                                            AppLocalizations.of(context)!.date,
                                        icon: Icon(Icons
                                            .calendar_today), //icon of text field
                                      ),
                                      readOnly: true,
                                      controller: dateController,
                                      textInputAction: TextInputAction.done,
                                      onTap: () => _selectDate(context),
                                    ),
                                  )
                                ],
                              ),
                            ]),
                          ]),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilledButton(
                              onPressed: () {
                                saveRecord(context);
                              },
                              child: Text(AppLocalizations.of(context)!.ok),
                            ),
                            OutlinedButton(
                              onPressed: () => {Navigator.of(context).pop()},
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
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
    dateController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enter_value_message;
    }
    return null;
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: record?.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      setState(() {
        dateController
          ..text = DateFormat(AppConstants.dateFormat).format(newSelectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: dateController.text.length,
              affinity: TextAffinity.upstream));
      });
    }
  }

  void saveRecord(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String description = descriptionController.text;
      int reps = int.tryParse(repsController.text) ?? AppConstants.emptyValue;
      int series =
          int.tryParse(seriesController.text) ?? AppConstants.emptyValue;
      int time = int.tryParse(timeController.text) ?? AppConstants.emptyValue;
      int weight =
          int.tryParse(weightController.text) ?? AppConstants.emptyValue;
      String notes = notesController.text;
      DateTime date = DateFormat(AppConstants.dateFormat)
              .tryParse(dateController.text) ??
          DateFormat(AppConstants.dateFormat).parse(
              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");

      if (isNew) {
        context.read<WorkoutModel>().addRecord(
            name: description,
            series: series,
            reps: reps,
            time: time,
            weight: weight,
            notes: notes,
            date: date);
      } else {
        context.read<WorkoutModel>().editRecord(
            record: record!,
            name: description,
            series: series,
            reps: reps,
            time: time,
            weight: weight,
            notes: notes,
            date: date);
      }
      Navigator.of(context).pop();
    }
  }
}
