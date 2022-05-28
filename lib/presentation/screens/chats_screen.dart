import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_gloabl_elements.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/presentation/widgets/user_dp.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 106,
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16)
                    .copyWith(left: 16, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                          color: AppColors.grey1, shape: BoxShape.circle),
                      child: SvgPicture.asset(Assets.vectorsIcPlus,
                          width: 20,
                          height: 20,
                          color: AppColors.iconColorActive),
                    ),
                    Text("Your Story",
                        style: TextStyle(color: AppColors.grey4, fontSize: 13)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const RecentUser(size: 52);
                    },
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (_, index) =>
                        SizedBox(width: index == 0 ? 8 : 16),
                    itemCount: 12),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              var textStyle = TextStyle(color: AppColors.grey4);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserDp(size: 60),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              faker.person.name(),
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  "You : What's man!",
                                  maxLines: 2,
                                  style: textStyle,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text("•",
                                      style: textStyle.copyWith(fontSize: 6)),
                                ),
                                Text(
                                  "9:04 AM",
                                  style: textStyle,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      Assets.vectorsIcCheckTrue,
                      width: 16,
                      height: 16,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecentUser extends StatelessWidget {
  const RecentUser({Key? key, required this.size}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserDp(size: size, active: true),
        SizedBox(height: 6),
        Text(
          faker.person.firstName(),
          style: TextStyle(color: AppColors.grey4, fontSize: 13),
        )
      ],
    );
  }
}
