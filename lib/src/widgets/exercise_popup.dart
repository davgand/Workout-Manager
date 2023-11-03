import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/model/workout.dart';

class ExerciseDialog extends StatefulWidget {
  final Exercise? exercise;
  final Day day;

  ExerciseDialog(this.day, [this.exercise]);

  @override
  State<ExerciseDialog> createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Exercise? exercise;
  Day day = Day.create(id: 0, description: "", exercises: []);
  bool isNew = true;

  @override
  initState() {
    day = widget.day;
    if (widget.exercise != null) {
      isNew = false;
      exercise = widget.exercise;
      descriptionController = TextEditingController()..text = exercise!.name;
      repsController = TextEditingController()
        ..text = exercise!.reps.toString();
      weightController = TextEditingController()
        ..text = exercise!.weight.toString();
      notesController = TextEditingController()..text = exercise!.notes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String title =
    //  widget.exercise == null ? "Add new Exercise" : "Edit Exercise";

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
          width: 350,
          height: 350,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Description",
                                hintText: "Enter description"),
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
                                  labelText: "Reps", hintText: "Enter Reps"),
                              textInputAction: TextInputAction.next,
                              controller: repsController,
                              validator: (value) => validateInput(value),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                labelText: "Weight", hintText: "Enter Weight"),
                            textInputAction: TextInputAction.next,
                            controller: weightController,
                            validator: (value) => validateInput(value),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Notes", hintText: "Enter notes"),
                            controller: notesController,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                  ]),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              saveExercise(context, day);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Palette.blue),
                            ),
                            child: const Text("Ok"),
                          ),
                          ElevatedButton(
                            onPressed: () => {Navigator.of(context).pop()},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Palette.white),
                            ),
                            child: const Text(
                              "Cancel",
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
    weightController.dispose();
    notesController.dispose();
    super.dispose();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a value";
    }
    return null;
  }

  void saveExercise(BuildContext context, Day day) {
    if (_formKey.currentState!.validate()) {
      // var day = Provider.of<Day>(context, listen: false);
      // var day = context.read<Day>();
      String description = descriptionController.text;
      int reps = int.parse(repsController.text);
      int weight = int.parse(weightController.text);
      String notes = notesController.text;

      if (isNew) {
        context
            .read<WorkoutModel>()
            .addExercise(day, description, reps, weight, notes);
        //day.addExercise(
        //  name: description, reps: reps, weight: weight, notes: notes);
      } else {
        context
            .read<WorkoutModel>()
            .editExercise(day, exercise!.id, description, reps, weight, notes);
      }
      Navigator.of(context).pop();
    }
  }
}
