import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kUser = 'user';
  static const kOnboarding = 'onboarding';

  Future<void> invalidate() async {
    final sf = await SharedPreferences.getInstance();
    await sf.setBool(kUser, false);
    await sf.setBool(kOnboarding, false);
  }

  Future<void> cacheUser() async {
    final sf = await SharedPreferences.getInstance();
    await sf.setBool(kUser, true);
  }

  Future<void> completeOnboarding() async {
    final sf = await SharedPreferences.getInstance();
    await sf.setBool(kOnboarding, true);
  }

  Future<bool> isUserLoggedIn() async {
    final sf = await SharedPreferences.getInstance();
    return sf.getBool(kUser) ?? false;
  }

  Future<bool> didCompleteOnboarding() async {
    final sf = await SharedPreferences.getInstance();
    return sf.getBool(kOnboarding) ?? false;
  }
}