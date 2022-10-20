import 'package:alive_and_kicking/models/app_state_manager.dart';
import 'package:alive_and_kicking/models/grocery_manager.dart';
import 'package:alive_and_kicking/models/profile_manager.dart';
import 'package:alive_and_kicking/navigation/app_route_parser.dart';
import 'package:alive_and_kicking/navigation/app_router.dart';
import 'package:alive_and_kicking/theme/alive_and_kicking_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AliveAndKicking());
}

class AliveAndKicking extends StatefulWidget {
  const AliveAndKicking({Key? key}) : super(key: key);

  @override
  State<AliveAndKicking> createState() => _AliveAndKickingState();
}

class _AliveAndKickingState extends State<AliveAndKicking> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();
  final routeParser = AppRouteParser();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = AliveAndKickingTheme.dark();
          } else {
            theme = AliveAndKickingTheme.light();
          }
          // created a MaterialApp that initializes an internal router.
          return MaterialApp.router(
            theme: theme,
            title: 'Alive & Kicking',
            backButtonDispatcher: RootBackButtonDispatcher(),
            // routerDelegate helps construct the stack of pages that represents
            // your app state.
            routerDelegate: _appRouter,
            // Set routeParser. Remember that the route information parser’s job
            // is to convert the app state to and from a URL string.
            routeInformationParser: routeParser,
          );
        },
      ),
    );
  }
}

