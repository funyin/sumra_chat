import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumra_chat/models/item_chat_model.dart';
import 'package:sumra_chat/presentation/screens/chat_screen/chat_screen.dart';
import 'package:sumra_chat/presentation/screens/main_app.dart';
import 'package:sumra_chat/presentation/screens/profile_screen.dart';

class AppRoutes {
  static const mainAppScreen = "/";
  static const chat = "/chat";
  static const newMessageScreen = "/newMessage";
  static const profileScreen = "/profile";

  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;
    switch (routeSettings.name) {
      case chat:
        return CupertinoPageRoute(
            builder: (context) => ChatScreen(chat: args as ChatModel),
            settings: routeSettings);
      case mainAppScreen:
        return CupertinoPageRoute(
            builder: (context) => const MainAppScreen(),
            settings: routeSettings);
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
