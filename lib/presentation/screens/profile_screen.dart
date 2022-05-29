import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/bloc/state.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
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
  late var topLevelActions = <String, Widget>{
    "Color": Container(
      height: 24,
      width: 24,
      decoration:
          const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Container(
        height: 8,
        width: 8,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      ),
    ),
    "Emoji": SvgPicture.asset(
      Assets.vectorsIcThumbUp,
      color: AppColors.blue,
      height: 22.03,
    ),
    "Nicknames": SvgPicture.asset(
      Assets.vectorsIcArrowRight,
      height: 13,
      color: Colors.black.withOpacity(0.2),
    )
  };

  late var moreActions = <String, Widget>{
    "Search in Conversation": Container(
      height: 32,
      width: 32,
      decoration:
          const BoxDecoration(color: AppColors.grey1, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        Assets.vectorsIcSearch,
        height: 14,
        color: AppColors.iconColorActive,
      ),
    ),
    "Create Group": Container(
      height: 32,
      width: 32,
      decoration:
          const BoxDecoration(color: AppColors.grey1, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        Assets.vectorsIcGroup,
        height: 13,
        color: AppColors.iconColorActive,
      ),
    )
  };

  late var privacyActions = <String, Widget>{
    "Notifications": Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "On",
          style: TextStyle(color: Colors.black.withOpacity(0.35), fontSize: 17),
        ),
        SizedBox(width: 6),
        SvgPicture.asset(
          Assets.vectorsIcArrowRight,
          height: 13,
          color: Colors.black.withOpacity(0.2),
        )
      ],
    ),
    "Ignore Messages": Container(
      height: 32,
      width: 32,
      decoration:
          const BoxDecoration(color: AppColors.grey1, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        Assets.vectorsHide,
        height: 15,
        color: AppColors.iconColorActive,
      ),
    ),
    "Block": const SizedBox()
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        var user = state.signedInUser;
        return Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 259 + MediaQuery.of(context).padding.top,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.imagesProfileBackground),
                      fit: BoxFit.cover)),
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
                        UserDp(
                          size: 100,
                          user: user,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                          child: Text(
                            user.name,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: 62,
                          child: ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  profileActionItems[index],
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 26),
                              itemCount: 4),
                        )
                      ],
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 24.0, bottom: 24),
                          child: SvgPicture.asset(
                            Assets.vectorsIcBack,
                            color: AppColors.iconColorActive,
                            height: 22,
                            width: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildSectionItems(topLevelActions),
                          buildSectionTitle("More actions"),
                          buildSectionItems(moreActions),
                          buildSectionTitle("Privacy"),
                          buildSectionItems(privacyActions),
                        ]))),
          ],
        ));
      },
    );
  }

  ListView buildSectionItems(Map<String, Widget> items) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          var item = items.entries.elementAt(index);
          return SizedBox(
              height: 52,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.key,
                      style: const TextStyle(fontSize: 17),
                    ),
                    item.value
                  ]));
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: items.length);
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black.withOpacity(0.35)),
      ),
    );
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
          margin: const EdgeInsets.only(bottom: 6),
          child: SvgPicture.asset(icon),
          decoration: const BoxDecoration(
              color: AppColors.grey1, shape: BoxShape.circle),
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
