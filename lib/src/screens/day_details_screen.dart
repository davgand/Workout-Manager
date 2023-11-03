// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/widgets/exercise_list.dart';

import '../constants/app_styles.dart';
import '../widgets/exercise_popup.dart';

class DayDetailsScreen extends StatefulWidget {
  final Day day;

  DayDetailsScreen({
    super.key,
    required this.day,
  });

  @override
  State<DayDetailsScreen> createState() => _DayDetailsScreenState();
}

class _DayDetailsScreenState extends State<DayDetailsScreen> {
  Day day = Day.create(id: 0, description: "", exercises: []);

  @override
  initState() {
    day = widget.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayExerciseDialog(context, day);
        },
        shape: AppStyles.floatButtonShape,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(day.description),
      ),
      body: ExerciseList(
        day: day,
        exercises: day.exercises,
      ),
    );
  }

  Future<void> displayExerciseDialog(BuildContext context, Day day) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ExerciseDialog(day);
        });
  }
}
