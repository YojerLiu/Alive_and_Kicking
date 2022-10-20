import 'package:alive_and_kicking/models/user.dart';
import 'package:flutter/material.dart';

class ProfileManager extends ChangeNotifier {
  bool _didSelectUser = false;
  bool _tapOnAliveAndKicking = false;
  bool _darkMode = false;

  bool get didSelectUser => _didSelectUser;

  bool get didTapOnAliveAndKicking => _tapOnAliveAndKicking;

  bool get darkMode => _darkMode;

  User get getUser => User(
        firstName: 'Stef',
        lastName: 'Patt',
        role: 'Handstander',
        profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
        points: 100,
        darkMode: _darkMode,
      );

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnAliveAndKicking(bool selected) {
    _tapOnAliveAndKicking = selected;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}