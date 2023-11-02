import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/workout.dart';

class DayDialog extends StatefulWidget {
  final Day? day;

  DayDialog([this.day]);

  @override
  State<DayDialog> createState() => _DayDialogState();
}

class _DayDialogState extends State<DayDialog> {
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Day? day;
  bool isNew = true;

  @override
  initState() {
    if (widget.day != null) {
      isNew = false;
      day = widget.day;
      descriptionController = TextEditingController()..text = day!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String title =
    //  widget.Day == null ? "Add new Day" : "Edit Day";

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
          height: 200,
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
                            controller: descriptionController,
                            validator: (value) => validateInput(value),
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
                              saveDay(context);
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
    super.dispose();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a value";
    }
    return null;
  }

  void saveDay(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // var day = Provider.of<Day>(context, listen: false);
      // var day = context.read<Day>();
      String description = descriptionController.text;

      if (isNew) {
        context.read<WorkoutModel>().addDay(description: description);
      } else {
        context
            .read<WorkoutModel>()
            .editDay(id: day!.id, description: description);
      }
      Navigator.of(context).pop();
    }
  }
}
