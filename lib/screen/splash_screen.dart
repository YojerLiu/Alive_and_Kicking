import 'package:alive_and_kicking/models/alive_and_kicking_pages.dart';
import 'package:alive_and_kicking/models/app_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  // Define a static method to create a MaterialPage that sets the appropriate
  // unique identifier and creates SplashScreen.
  static MaterialPage page() {
    return MaterialPage(
      name: AliveAndKickingPages.splashPath,
      key: ValueKey(AliveAndKickingPages.splashPath),
      child: const SplashScreen(),
    );
  }
  
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // use the current context to retrieve the AppStateManager to initialize the
    // app.
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Image(
              height: 200,
              image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
            ),
            Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
