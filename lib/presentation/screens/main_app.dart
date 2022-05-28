import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/presentation/routes/app_router.dart';
import 'package:sumra_chat/presentation/screens/chats_screen.dart';
import 'package:sumra_chat/presentation/screens/people_screen.dart';
import 'package:sumra_chat/presentation/screens/settings_screen.dart';
import 'package:sumra_chat/presentation/widgets/user_dp.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  var activeIndex = 0;
  final bottomNavIcons = {
    "Chats": Assets.vectorsIcChat,
    "People": Assets.vectorsIcPeople,
    "Settings": Assets.vectorsIcSettings
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: const UserDp(size: 40),
                        onTap: () {
                          Navigator.pushNamed(context, AppRouter.profileScreen);
                        },
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "Chats",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      buildIconContainer(Assets.vectorsIcCamera),
                      const SizedBox(width: 16),
                      buildIconContainer(Assets.vectorsIcEnter),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 42,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: TextField(
                        maxLines: 1,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                            fillColor: AppColors.grey2,
                            filled: true,
                            hintText: "Search",
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            isDense: true,
                            suffixIcon: SizedBox(
                              width: 20,
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.vectorsIcSearch,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: activeIndex,
                children: const [
                  ChatsScreen(),
                  PeopleScreen(),
                  SettingsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 74,
        child: BottomNavigationBar(
          currentIndex: activeIndex,
          backgroundColor: const Color(0xffFAFBFC).withOpacity(0.92),
          fixedColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: List.generate(bottomNavIcons.length, (index) {
            var active = index == activeIndex;
            double size = 24;
            var color = active
                ? AppColors.iconColorActive
                : AppColors.iconColorInactive;
            var icon = bottomNavIcons.values.elementAt(index);
            var label = bottomNavIcons.keys.elementAt(index);
            return BottomNavigationBarItem(
                label: label,
                icon: index != 1
                    ? SvgPicture.asset(
                        icon,
                        height: size,
                        width: size,
                        color: color,
                      )
                    : SizedBox(
                        width: 32,
                        height: 30,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Positioned.fill(
                              top: 3,
                              right: 8,
                              child: SvgPicture.asset(
                                icon,
                                color: color,
                              ),
                            ),
                            Container(
                              height: 16,
                              width: 16,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                  color: AppColors.blue,
                                  shape: BoxShape.circle),
                              child: const FittedBox(
                                  child: Text(
                                "2",
                                style: TextStyle(
                                    color: AppColors.grey2,
                                    fontWeight: FontWeight.w700),
                              )),
                            )
                          ],
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

  Container buildIconContainer(String icon) {
    return Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.grey1,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          color: AppColors.iconColorActive,
          height: 19.5,
          width: 19.5,
        ));
  }
}
