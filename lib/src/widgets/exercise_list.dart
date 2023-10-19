// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gym_manager/src/model/exercise.dart';
import 'package:gym_manager/src/widgets/exercise_item.dart';

class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;
  final ValueChanged<Exercise>? onTap;

  const ExerciseList({
    required this.exercises,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) => Row(children: [
              ExerciseItem(
                exercise: exercises[index],
              )
            ]));
  }
}
