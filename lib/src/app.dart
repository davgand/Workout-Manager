import 'package:flutter/material.dart';
import 'package:gym_manager/src/auth.dart';
import 'package:provider/provider.dart';

import 'model/workout.dart';
import 'router/delegate.dart';
import 'router/parsed_route.dart';
import 'router/parser.dart';
import 'router/route_state.dart';
import 'screens/navigator.dart';

class WorkoutManagerApp extends StatefulWidget {
  const WorkoutManagerApp({super.key});

  @override
  State<WorkoutManagerApp> createState() => _WorkoutManagerState();
}

class _WorkoutManagerState extends State<WorkoutManagerApp> {
  final _auth = WorkoutAuth();
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final RouteState _routeState;
  late final SimpleRouterDelegate _routerDelegate;
  late final TemplateRouteParser _routeParser;

  @override
  void initState() {
    /// Configure the parser with all of the app's allowed path templates.
    _routeParser = TemplateRouteParser(
      allowedPaths: [
        '/signin',
        '/workout',
        '/settings',
        '/exercise/new',
        '/day/new',
        '/day/:dayId',
        '/author/:authorId',
      ],
      guard: _guard,
      initialRoute: '/signin',
    );

    _routeState = RouteState(_routeParser);

    _routerDelegate = SimpleRouterDelegate(
      routeState: _routeState,
      navigatorKey: _navigatorKey,
      builder: (context) => WorkoutNavigator(
        navigatorKey: _navigatorKey,
      ),
    );

    // Listen for when the user logs out and display the signin screen.
    _auth.addListener(_handleAuthStateChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => RouteStateScope(
        notifier: _routeState,
        child: WorkoutAuthScope(
          notifier: _auth,
          child: MaterialApp.router(
            routerDelegate: _routerDelegate,
            routeInformationParser: _routeParser,
            // Revert back to pre-Flutter-2.5 transition behavior:
            // https://github.com/flutter/flutter/issues/82053
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                },
              ),
            ),
          ),
        ),
      );

  Future<ParsedRoute> _guard(ParsedRoute from) async {
    final signedIn = _auth.signedIn;
    final signInRoute = ParsedRoute('/signin', '/signin', {}, {});

    // Go to /signin if the user is not signed in
    if (!signedIn && from != signInRoute) {
      return signInRoute;
    }
    // Go to /books if the user is signed in and tries to go to /signin.
    else if (signedIn && from == signInRoute) {
      return ParsedRoute('/books/popular', '/books/popular', {}, {});
    }
    return from;
  }

  void _handleAuthStateChanged() {
    if (!_auth.signedIn) {
      _routeState.go('/signin');
    }
  }

  @override
  void dispose() {
    _auth.removeListener(_handleAuthStateChanged);
    _routeState.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => WorkoutModel(),
//       child: MaterialApp(
//         title: 'Workout Manager',
//         theme: ThemeData(
//           useMaterial3: true,
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         ),
//         home: const HomePage(),
//       ),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     var colorScheme = Theme.of(context).colorScheme;

//     Widget page;
//     switch (selectedIndex) {
//       case 0:
//         page = const StartingPage();
//         break;
//       case 1:
//         page = const WorkoutPage();
//         break;
//       default:
//         throw UnimplementedError("no widget for $selectedIndex");
//     }

//     var mainArea = ColoredBox(
//         color: colorScheme.surfaceVariant,
//         child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 200), child: page));

//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth < 450) {
//             // Use a more mobile-friendly layout with BottomNavigationBar
//             // on narrow screens.
//             return Column(
//               children: [
//                 Expanded(child: mainArea),
//                 SafeArea(
//                   child: BottomNavigationBar(
//                     items: const [
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.home),
//                         label: 'Home',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.favorite),
//                         label: 'Favorites',
//                       ),
//                     ],
//                     currentIndex: selectedIndex,
//                     onTap: (value) {
//                       setState(() {
//                         selectedIndex = value;
//                       });
//                     },
//                   ),
//                 )
//               ],
//             );
//           } else {
//             return Row(
//               children: [
//                 SafeArea(
//                   child: NavigationRail(
//                     extended: constraints.maxWidth >= 600,
//                     destinations: const [
//                       NavigationRailDestination(
//                         icon: Icon(Icons.home),
//                         label: Text('Home'),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.favorite),
//                         label: Text('Favorites'),
//                       ),
//                     ],
//                     selectedIndex: selectedIndex,
//                     onDestinationSelected: (value) {
//                       setState(() {
//                         selectedIndex = value;
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(child: mainArea),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class StartingPage extends StatelessWidget {
//   const StartingPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<WorkoutModel>();

//     return Center(
//       child: Text("PROVA"),
//     );
//   }
// }

// class WorkoutPage extends StatelessWidget {
//   const WorkoutPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Icon(Icons.account_circle, size: 50),
//       ),
//       Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Flutter McFlutter',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           const Text('Experienced App Developer'),
//         ],
//       )
//     ]);
//   }
// }
