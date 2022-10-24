import 'package:alive_and_kicking/models/alive_and_kicking_pages.dart';
import 'package:alive_and_kicking/models/app_state_manager.dart';
import 'package:alive_and_kicking/models/grocery_manager.dart';
import 'package:alive_and_kicking/models/profile_manager.dart';
import 'package:alive_and_kicking/navigation/app_link.dart';
import 'package:alive_and_kicking/screen/grocery_item_screen.dart';
import 'package:alive_and_kicking/screen/home.dart';
import 'package:alive_and_kicking/screen/login_screen.dart';
import 'package:alive_and_kicking/screen/onboarding_screen.dart';
import 'package:alive_and_kicking/screen/profile_screen.dart';
import 'package:alive_and_kicking/screen/splash_screen.dart';
import 'package:alive_and_kicking/screen/webview_screen.dart';
import 'package:flutter/material.dart';

/// It extends RouterDelegate. The system will tell the router to build and
/// configure a navigator widget. Instead of telling the navigator what to do
/// with push() and pop(), you tell it: when the state is x, render y pages.
class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  // Declares GlobalKey, a unique key across the entire app.
  final GlobalKey<NavigatorState> myNavigatorKey;

  // Declares AppStateManager. The router will listen to app state changes to
  // configure the navigator’s list of pages.
  final AppStateManager appStateManager;

  // Declares GroceryManager to listen to the user’s state when you create or
  // edit an item.
  final GroceryManager groceryManager;

  // Declares ProfileManager to listen to the user profile state.
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : myNavigatorKey = GlobalKey<NavigatorState>() {
    // When the state changes, the router will reconfigure the navigator with a
    // new set of pages.
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  // When you dispose the router, you must remove all listeners. Forgetting to
  // do this will throw an exception.
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      // Uses the navigatorKey, which is required to retrieve the current
      // navigator.
      key: myNavigatorKey,
      // It’s called every time a page pops from the stack.
      onPopPage: _handlePopPage,
      // Declares pages, the stack of pages that describes your navigation stack.
      pages: [
        if (!appStateManager.isInitialized)
          SplashScreen.page(),

        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),

        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),

        if (appStateManager.isOnboardingComplete)
          Home.page(appStateManager.getSelectedTab),

        if (groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
            // After this callback is called, _createNewItem will be false.
            // Thus, the app come back to show Home.page(2).
            onCreate: (item) => groceryManager.addItem(item),
            onUpdate: (item, index) {},
          ),

        if (groceryManager.selectedIndex != -1)
          GroceryItemScreen.page(
            item: groceryManager.selectedGroceryItem,
            index: groceryManager.selectedIndex,
            onCreate: (item) {},
            // After this callback is called, _createNewItem will be false and
            // _selectedIndex will be -1. Thus, the app come back to show
            // Home.page(2).
            onUpdate: (item, index) => groceryManager.updateItem(item, index),
          ),

        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),

        if (profileManager.didTapOnAliveAndKicking)
          WebViewScreen.page(),
      ],
    );
  }

  /// When the user taps the **Back** button or triggers a system back button
  /// event, it fires a helper method, `onPopPage`.
  ///
  /// `Route<dynamic> route`: the current `route`, which contains information
  /// like `RouteSettings` to retrieve the route's name and arguments.
  ///
  /// `result`: the value that returns when the route completes - for example, a
  /// value that a dialog returns.
  bool _handlePopPage(Route<dynamic> route, result) {
    // Checks if the current route's pop succeeded. If it failed, return false.
    if (!route.didPop(result)) {
      return false;
    }

    // If the route pop succeeds, this checks the different routes and triggers
    // the appropriate state changes.
    // The name of each route is given by the static page() method of each
    // screen.

    // Handle Onboarding and splash
    if (route.settings.name == AliveAndKickingPages.onboardingPath) {
      appStateManager.logout();
    }
    // Handle state when user closes grocery item screen
    if (route.settings.name == AliveAndKickingPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }
    // Handle state when user closes profile screen
    if (route.settings.name == AliveAndKickingPages.profilePath) {
      profileManager.tapOnProfile(false);
    }
    // Handle state when user closes WebView screen
    if (route.settings.name == AliveAndKickingPages.aliveAndKicking) {
      profileManager.tapOnAliveAndKicking(false);
    }
    return true;
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => myNavigatorKey;

  /// Convert a URL to an app state. The user enters a new URL in the web
  /// browser's address bar. `RouteInformationParser` parses the new route into
  /// your navigation state (configuration), an instance of `AppLink`. Based on
  /// the navigation state, `RouterDelegate` updates the app state to reflect
  /// the new changes.
  @override
  Future<void> setNewRoutePath(AppLink configuration) async {
    switch (configuration.location) {
      case AppLink.kProfilePath:
        profileManager.tapOnProfile(true);
        break;
      case AppLink.kItemPath:
        final itemId = configuration.itemId;
        if (itemId != null) {
          groceryManager.setSelectedGroceryItem(itemId);
        } else {
          groceryManager.createNewItem();
        }
        profileManager.tapOnProfile(false);
        break;
      case AppLink.kHomePath:
        appStateManager.goToTab(configuration.currentTab ?? 0);
        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(-1);
        break;
      default:
        break;
    }
  }

  /// Convert app state to appLink
  AppLink getCurrentPath() {
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.kLoginPath);
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.kOnboardingPath);
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.kProfilePath);
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.kItemPath);
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem?.id;
      return AppLink(location: AppLink.kItemPath, itemId: id);
    } else {
      return AppLink(
        location: AppLink.kHomePath,
        currentTab: appStateManager.getSelectedTab,
      );
    }
  }

  /// checks the app state and returns the right app link configuration.
  @override
  AppLink get currentConfiguration => getCurrentPath();
}