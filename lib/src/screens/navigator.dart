// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gym_manager/src/model/day.dart';
import 'package:gym_manager/src/model/workout.dart';
import 'package:gym_manager/src/screens/scaffold.dart';
import 'package:gym_manager/src/screens/sign_in.dart';
import 'package:gym_manager/src/auth.dart';

import '../router/route_state.dart';
import '../widgets/fade_transition_page.dart';
import 'day_details_screen.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class WorkoutNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const WorkoutNavigator({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<WorkoutNavigator> createState() => _WorkoutNavigatorState();
}

class _WorkoutNavigatorState extends State<WorkoutNavigator> {
  final _signInKey = const ValueKey('Sign in');
  final _scaffoldKey = const ValueKey('App scaffold');
  final _exerciseDetailsKey = const ValueKey('Exercise details screen');
  final _dayDetailKey = const ValueKey('Day details screen');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final authState = WorkoutAuthScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    Day? selectedDay;
    if (pathTemplate == '/day/:dayId') {
      selectedDay = workoutInstance.days.firstWhereOrNull(
          (b) => b.id.toString() == routeState.route.parameters['dayId']);
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        // When a page that is stacked on top of the scaffold is popped, display
        // the /days.
        if (route.settings is Page &&
            (route.settings as Page).key == _dayDetailKey) {
          routeState.go('/workout');
        }

        return route.didPop(result);
      },
      pages: [
        if (routeState.route.pathTemplate == '/signin')
          // Display the sign in screen.
          FadeTransitionPage<void>(
            key: _signInKey,
            child: SignInScreen(
              onSignIn: (credentials) async {
                var signedIn = await authState.signIn(
                    credentials.username, credentials.password);
                if (signedIn) {
                  await routeState.go('/workout');
                }
              },
            ),
          )
        else ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const WorkoutScaffold(),
          ),
          // Add an additional page to the stack if the user is viewing a day
          if (selectedDay != null)
            MaterialPage<void>(
              key: _dayDetailKey,
              child: DayDetailsScreen(
                day: selectedDay,
              ),
            )
          // else if (selectedAuthor != null)
          //   MaterialPage<void>(
          //     key: _dayDetailKey,
          //     child: AuthorDetailsScreen(
          //       author: selectedAuthor,
          //     ),
          //   ),
        ],
      ],
    );
  }
}
