import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_gloabl_elements.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/presentation/widgets/user_dp.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  late var profileActionItems = [
    profileActionItem(Assets.vectorsIcPhone, "Audio", () {}),
    profileActionItem(Assets.vectorsIcVideo, "Video", () {}),
    profileActionItem(Assets.vectorsIcUser, "Profile", () {}),
    profileActionItem(Assets.vectorsIcBell, "Mute", () {})
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 259 + MediaQuery.of(context).padding.top,
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesProfileBackground))),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                    child: Image.asset(
                  Assets.imagesProfileBackground,
                  fit: BoxFit.cover,
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserDp(size: 100),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                      child: Text(
                        faker.person.name(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      height: 62,
                      child: ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              profileActionItems[index],
                          separatorBuilder: (_, __) => SizedBox(width: 26),
                          itemCount: 4),
                    )
                  ],
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  height: 22,
                  width: 22,
                  child: SvgPicture.asset(
                    Assets.vectorsIcBack,
                    color: AppColors.iconColorActive,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(),
      ],
    ));
  }

  profileActionItem(
    String icon,
    String title,
    VoidCallback onTap,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 6),
          child: SvgPicture.asset(icon),
          decoration:
              BoxDecoration(color: AppColors.grey1, shape: BoxShape.circle),
        ),
        Text(
          title,
          maxLines: 1,
          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
        )
      ],
    );
  }
}
