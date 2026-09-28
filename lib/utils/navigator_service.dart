import 'package:flutter/cupertino.dart';
import 'package:rnw_institue/routes/app_routes.dart';

class NavigatorService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Pushes a named route using CupertinoPageRoute for iOS-like right-to-left transitions
  static Future<dynamic> pushNamed(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState?.push(
      CupertinoPageRoute(
        settings: RouteSettings(name: routeName, arguments: arguments),
        builder: (context) => AppRoutes.routes[routeName]!(context),
      ),
    );
  }

  // Pops the top-most route off the navigator stack
  static void goBack({dynamic result}) {
    navigatorKey.currentState?.pop(result);
  }

  // Pushes a named route and removes all previous routes until the predicate is true
  static Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {required bool Function(Route<dynamic>) routePredicate,
      dynamic arguments}) async {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      CupertinoPageRoute(
        settings: RouteSettings(name: routeName, arguments: arguments),
        builder: (context) => AppRoutes.routes[routeName]!(context),
      ),
      routePredicate,
    );
  }

  // Pops the current route and pushes a new named route
  static Future<dynamic> popAndPushNamed(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState?.popAndPushNamed(
      routeName,
      arguments: arguments,
    );
  }

  // Pushes a new named route and replaces the current route
  static Future<dynamic> pushReplacement(String routeName,
      {dynamic arguments}) async {
    return navigatorKey.currentState?.pushReplacement(
      CupertinoPageRoute(
        settings: RouteSettings(name: routeName, arguments: arguments),
        builder: (context) => AppRoutes.routes[routeName]!(context),
      ),
    );
  }

  // Pops routes until the specified route is reached
  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  // Replaces an existing route with a new named route
  static Future<dynamic> replaceRoute(String oldRoute, String newRoute,
      {dynamic arguments}) async {
    navigatorKey.currentState?.removeRoute(
      ModalRoute.of(navigatorKey.currentState!.context)!,
    );
    return navigatorKey.currentState?.pushReplacement(
      CupertinoPageRoute(
        settings: RouteSettings(name: newRoute, arguments: arguments),
        builder: (context) => AppRoutes.routes[newRoute]!(context),
      ),
    );
  }

  // Pushes a named route and removes routes until the predicate returns true
  static Future<dynamic> pushAndRemoveUntil(String routeName,
      {required bool Function(Route<dynamic>) routePredicate,
      dynamic arguments}) async {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      CupertinoPageRoute(
        settings: RouteSettings(name: routeName, arguments: arguments),
        builder: (context) => AppRoutes.routes[routeName]!(context),
      ),
      routePredicate,
    );
  }
}
