// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:gym_manager/src/constants/app_styles.dart';
import 'package:gym_manager/src/model/workout.dart';
import 'package:gym_manager/src/widgets/days_list.dart';

class WorkoutScreen extends StatelessWidget {
  final String title = 'Workout';
  final WorkoutModel workout;

  const WorkoutScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: AppStyles.floatButtonShape,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(title),
        ),
        body: DaysList(
          days: workout.days,
        ),
      );
}
