// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gym_manager/src/model/day.dart';
import 'package:gym_manager/src/widgets/exercise_list.dart';

import '../constants/app_styles.dart';
import '../model/exercise.dart';
import 'exercise_edit_popup.dart';

class DayDetailsScreen extends StatelessWidget {
  Day day;

  DayDetailsScreen({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayExerciseDialog(context);
        },
        shape: AppStyles.floatButtonShape,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(day.description),
      ),
      body: ExerciseList(
        exercises: day.exercises,
      ),
    );
  }

  final _textFieldController = TextEditingController();

  Future<void> displayExerciseDialog(BuildContext context,
      [Exercise? exercise]) async {
    String title = exercise == null ? "Add new Exercise" : "Edit Exercise";

    return showDialog(
        context: context,
        builder: (context) {
          return ExerciseDialog();
        });
  }
}
