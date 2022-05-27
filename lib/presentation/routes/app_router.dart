import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumra_chat/presentation/screens/main_app.dart';
import 'package:sumra_chat/presentation/screens/profile_screen.dart';

class AppRouter {
  static const mainAppScreen = "/";
  static const onboarding = "/chat";
  static const newMessageScreen = "/newMessage";
  static const profileScreen = "/profile";

  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;
    switch (routeSettings.name) {
      case onboarding:
        return CupertinoPageRoute(
            builder: (context) => const MainAppScreen(),
            settings: routeSettings);
      case mainAppScreen:
        return CupertinoPageRoute(
            builder: (context) => MainAppScreen(), settings: routeSettings);
      case profileScreen:
        return CupertinoPageRoute(
            builder: (context) => ProfileScreen(), settings: routeSettings);
      default:
        return null;
    }
  }

  static String initialRoute() {
    return mainAppScreen;
  }
}
