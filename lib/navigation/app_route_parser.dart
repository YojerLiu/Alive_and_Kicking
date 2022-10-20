import 'package:alive_and_kicking/navigation/app_link.dart';
import 'package:flutter/material.dart';

/// `AppRouteParser` extends `RouteInformationParser`. Notice it takes a generic
/// type. In this case, your type is `AppLink`, which holds all the route and
/// navigation information.
class AppRouteParser extends RouteInformationParser<AppLink> {

  // The routeInformation contains the URL string.
  // Take the routeInformation and build an instance of AppLink from it.
  @override
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    final link = AppLink.fromLocation(routeInformation.location);
    return link;
  }

  // This function passes in an AppLink object. You ask AppLink to give you back
  // the URL string. You wrap it in RouteInformation to pass it along.
  @override
  RouteInformation restoreRouteInformation(AppLink configuration) {
    final location = configuration.toLocation();
    return RouteInformation(location: location);
  }
}