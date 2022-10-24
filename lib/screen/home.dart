import 'package:alive_and_kicking/models/alive_and_kicking_pages.dart';
import 'package:alive_and_kicking/models/app_state_manager.dart';
import 'package:alive_and_kicking/models/profile_manager.dart';
import 'package:alive_and_kicking/screen/diary_screen.dart';
import 'package:alive_and_kicking/screen/explore_screen.dart';
import 'package:alive_and_kicking/screen/grocery_screen.dart';
import 'package:alive_and_kicking/screen/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  final int currentTab;
  const Home({Key? key, required this.currentTab}) : super(key: key);

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: AliveAndKickingPages.home,
      key: ValueKey(AliveAndKickingPages.home),
      child: Home(currentTab: currentTab,),
    );
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static List<Widget> pages = [
    const ExploreScreen(),
    RecipeScreen(),
    const GroceryScreen(),
    const DiaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Alive & Kicking',
              // Theme.of(context) returns the nearest Theme in the widget tree.
              // If the widget has a defined Theme, it returns that. Otherwise,
              // it returns the app’s theme.
              style: Theme.of(context).textTheme.headline6,
            ),
            centerTitle: true,
            actions: <Widget>[
              profileButton(),
            ],
          ),
          // IndexedStack allows you to easily switch widgets in your app. It
          // only shows one child widget at a time, but it preserves the state
          // of all the children.
          // This can help to avoid the spinner and data reload every time, as
          // well as preserve the scroll position when you switch to another tab.
          body: IndexedStack(
            index: widget.currentTab,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
            unselectedItemColor: Colors.grey,
            currentIndex: widget.currentTab,
            // Calls manager.goToTab() when the user taps a different tab, to
            // notify other widgets that the index changed.
            onTap: appStateManager.goToTab,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'To Buy',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Diary',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16,),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/profile_pics/person_stef.jpeg'),
        ),
        onTap: () {
          Provider.of<ProfileManager>(context, listen: false)
              .tapOnProfile(true);
        },
      ),
    );
  }
}
