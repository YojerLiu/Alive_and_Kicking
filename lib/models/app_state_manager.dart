import 'dart:async';

import 'package:alive_and_kicking/models/app_cache.dart';
import 'package:flutter/material.dart';

class AliveAndKickingTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _onboardingComplete = false;
  int _selectedTab = AliveAndKickingTab.explore;
  final _appCache = AppCache();

  // These are getter methods for each property. You cannot change these
  // properties outside AppStateManager. This is important for the
  // unidirectional flow architecture, where you don’t change state directly but
  // only via function calls or dispatched events.
  bool get isInitialized => _initialized;

  bool get isLoggedIn => _loggedIn;

  bool get isOnboardingComplete => _onboardingComplete;

  int get getSelectedTab => _selectedTab;

  void initializeApp() async {
    _loggedIn = await _appCache.isUserLoggedIn();
    _onboardingComplete = await _appCache.didCompleteOnboarding();

    Timer(
      const Duration(milliseconds: 4000,),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  void login(String userName, String password) async {
    _loggedIn = true;
    await _appCache.cacheUser();
    notifyListeners();
  }

  void completeOnboarding() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void goToTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = AliveAndKickingTab.recipes;
    notifyListeners();
  }

  void logout() async {
    _initialized = false;
    _selectedTab = 0;
    await _appCache.invalidate();
    initializeApp();
    notifyListeners();
  }
}