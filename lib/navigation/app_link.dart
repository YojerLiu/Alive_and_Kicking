/// AppLink is your navigation state object.
///
/// **Path:/** means **alive\_and\_kicking://alive\_and\_kicking.com**
///
/// **/login**: Redirect to the Login screen if the user isn't logged in yet.
/// ```
/// alive_and_kicking://alive_and_kicking.com/login
/// ```
/// **/onboarding**: Redirects to the Onboarding screen if the user hasn't
/// completed the onboarding.
/// ```
/// alive_and_kicking://alive_and_kicking.com/onboarding
/// ```
/// **Path:/home?tab=[[index]]** can be:
/// ```
/// alive_and_kicking://alive_and_kicking.com/home?tab=0
/// ```
/// **Path:/profile** can be:
/// ```
/// alive_and_kicking://alive_and_kicking.com/profile
/// ```
/// **Path:/item?id=[[uuid]]** can be:
/// ```
/// alive_and_kicking://alive_and_kicking.com/item?id=2
/// ```
class AppLink {
  static const String kHomePath = '/home';
  static const String kOnboardingPath = '/onboarding';
  static const String kLoginPath = '/login';
  static const String kProfilePath = '/profile';
  static const String kItemPath = '/item';

  static const String kTabParam = 'tab';
  static const String kIdParam = 'id';

  // Store the path of the URL using location.
  String? location;
  // Use currentTab to store the tab you want to redirect the user to.
  int? currentTab;
  // Store the ID of the item you want to view in itemId.
  String? itemId;

  AppLink({this.location, this.currentTab, this.itemId});

  static AppLink fromLocation(String? location) {
    // First, you need to decode the URL. URLs often include special characters
    // in their paths, so you need to percent-encode the URL path. For example,
    // you’d encode hello!world to hello%21world.
    location = Uri.decodeFull(location ?? '');
    // Parse the URI for query parameter keys and key-value pairs.
    final uri = Uri.parse(location);
    final params = uri.queryParameters;

    final currentTab = int.tryParse(params[AppLink.kTabParam] ?? '');
    final itemId = params[AppLink.kIdParam];
    final link = AppLink(
      location: uri.path,
      currentTab: currentTab,
      itemId: itemId,
    );
    return link;
  }

  /// e.g., `https://example.com/api/fetch?limit=10,20,30&max=100`
  ///
  /// the key-value pairs would be:
  /// ```
  /// {"limit":"10,20,30","max":"100"}
  /// ```
  String _addKeyValPair({required String key, String? value}) {
    return value == null ? '' : '$key=$value&';
  }

  String toLocation() {
    switch (location) {
      case kLoginPath:
        return kLoginPath;
      case kOnboardingPath:
        return kOnboardingPath;
      case kProfilePath:
        return kProfilePath;
      case kItemPath:
        var loc = '$kItemPath?';
        loc += _addKeyValPair(key: kIdParam, value: itemId);
        return Uri.encodeFull(loc);
      default:
        var loc = '$kHomePath?';
        loc += _addKeyValPair(key: kTabParam, value: currentTab.toString());
        return Uri.encodeFull(loc);
    }
  }
}