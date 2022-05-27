import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/presentation/screens/chats_screen.dart';
import 'package:sumra_chat/presentation/screens/people_screen.dart';
import 'package:sumra_chat/presentation/screens/settings_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  var activeIndex = 0;
  final bottomNavIcons = [
    Assets.vectorsIcChat,
    Assets.vectorsIcPeople,
    Assets.vectorsIcSettings
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: IndexedStack(
        index: activeIndex,
        children: const [
          ChatsScreen(),
          PeopleScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        child: BottomNavigationBar(
          currentIndex: activeIndex,
          backgroundColor: AppColors.primaryLight,
          fixedColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: List.generate(bottomNavIcons.length, (index) {
            var active = index == activeIndex;
            double size = active ? 20 : 24;
            double opacity = active ? 1 : 0.6;
            var icon = bottomNavIcons[index];
            var label = bottomNavIcons[index];
            return BottomNavigationBarItem(
                label: label,
                icon: Opacity(
                  key: ValueKey(index),
                  opacity: opacity,
                  child: SvgPicture.asset(
                    icon,
                    width: size,
                    height: size,
                  ),
                ));
          }, growable: false),
          onTap: (value) => setState(() {
            activeIndex = value;
          }),
        ),
      ),
    );
  }
}
