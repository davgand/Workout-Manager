// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gym_manager/src/model/day.dart';
import 'package:gym_manager/src/widgets/exercise_list.dart';

class DayDetailsScreen extends StatelessWidget {
  final Day day;

  const DayDetailsScreen({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(day.description),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ExerciseList(
                exercises: day.exercises,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
