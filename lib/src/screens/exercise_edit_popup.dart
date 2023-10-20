import 'package:flutter/material.dart';
import 'package:gym_manager/src/constants/app_styles.dart';
import 'package:gym_manager/src/model/exercise.dart';
import 'package:window_size/window_size.dart';

class ExerciseDialog extends StatefulWidget {
  ExerciseDialog({super.key});

  @override
  State<ExerciseDialog> createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  final descriptionController = TextEditingController();
  final repsController = TextEditingController();
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(20)),
              color: Colors.white,
            ),
            width: 350,
            height: 350,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: "Description",
                                hintText: "Enter description"),
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
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Reps", hintText: "Enter Reps"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Weight", hintText: "Enter Weight"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: "Notes", hintText: "Enter notes"),
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
                            onPressed: () => {},
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
        ));
  }
}
