// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:workout_manager/src/model/day.dart';
import 'package:workout_manager/src/model/exercise.dart';
import 'package:workout_manager/src/widgets/exercise_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;
  final Day day;
  final ValueChanged<Exercise>? onTap;

  const ExerciseList({
    required this.day,
    required this.exercises,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return exercises.isEmpty
        ? Center(
            child: Text(
              AppLocalizations.of(context).no_exercises_in_list,
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) => ExerciseItem(
              day: day,
              exercise: exercises[index],
            ));
  }
}
