// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:gym_manager/src/screens/day_details_screen.dart';
import 'package:gym_manager/src/screens/workout.dart';
import 'package:gym_manager/src/screens/settings.dart';

import '../router/route_state.dart';
import '../widgets/fade_transition_page.dart';

class WorkoutScaffold extends StatelessWidget {
  const WorkoutScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: const WorkoutScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/home');
          if (idx == 1) routeState.go('/workout');
          if (idx == 2) routeState.go('/settings');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Home',
            icon: Icons.home_filled,
          ),
          AdaptiveScaffoldDestination(
            title: 'Workout',
            icon: Icons.sports_gymnastics,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/home')) return 0;
    if (pathTemplate == '/workout') return 1;
    if (pathTemplate == '/settings') return 2;
    return 0;
  }
}

/// Displays the contents of the body of [BookstoreScaffold]
class WorkoutScaffoldBody extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const WorkoutScaffoldBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentRoute = RouteStateScope.of(context).route;

    // A nested Router isn't necessary because the back button behavior doesn't
    // need to be customized.
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, dynamic result) => route.didPop(result),
      pages: [
        if (currentRoute.pathTemplate.startsWith('/workout'))
          const FadeTransitionPage<void>(
            key: ValueKey('workout'),
            child: WorkoutScreen(),
          )
        else if (currentRoute.pathTemplate.startsWith('/settings'))
          const FadeTransitionPage<void>(
            key: ValueKey('settings'),
            child: SettingsScreen(),
          )
        // else if (currentRoute.pathTemplate.startsWith('/home') ||
        //     currentRoute.pathTemplate == '/')
        //   const FadeTransitionPage<void>(
        //     key: ValueKey('settings'),
        //     child: SettingsScreen(),
        //   )

        // Avoid building a Navigator with an empty `pages` list when the
        // RouteState is set to an unexpected path, such as /signin.
        //
        // Since RouteStateScope is an InheritedNotifier, any change to the
        // route will result in a call to this build method, even though this
        // widget isn't built when those routes are active.
        else
          FadeTransitionPage<void>(
            key: const ValueKey('empty'),
            child: Container(),
          ),
      ],
    );
  }
}
