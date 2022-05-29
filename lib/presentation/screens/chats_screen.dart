import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/bloc/state.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/models/item_chat_model.dart';
import 'package:sumra_chat/presentation/widgets/list_items/chat_item.dart';
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
                padding: const EdgeInsets.symmetric(vertical: 16)
                    .copyWith(left: 16, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: const BoxDecoration(
                          color: AppColors.grey1, shape: BoxShape.circle),
                      child: SvgPicture.asset(Assets.vectorsIcPlus,
                          width: 20,
                          height: 20,
                          color: AppColors.iconColorActive),
                    ),
                    const Text("Your Story",
                        style: TextStyle(color: AppColors.grey4, fontSize: 13)),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ChatsCubit, ChatsState>(
                  builder: (context, state) {
                    var usersWithStories = state.respondents
                        .where((element) => element.hasStory)
                        .toList();
                    return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return RecentUser(
                            size: 52,
                            user: usersWithStories[index],
                          );
                        },
                        padding: const EdgeInsets.all(16),
                        separatorBuilder: (_, index) =>
                            SizedBox(width: index == 0 ? 8 : 16),
                        itemCount: usersWithStories.length);
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<ChatsCubit, ChatsState>(
            builder: (context, state) {
              var recentChats = state.recentChats;
              recentChats.sort(
                (a, b) => b.messages.last.time.compareTo(a.messages.last.time),
              );
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ChatItem(chat: recentChats[index]);
                },
                itemCount: recentChats.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecentUser extends StatelessWidget {
  const RecentUser({Key? key, required this.size, required this.user})
      : super(key: key);
  final double size;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserDp(size: size, user: user),
        const SizedBox(height: 6),
        Text(
          user.name.trim().split(" ").first,
          style: const TextStyle(color: AppColors.grey4, fontSize: 13),
        )
      ],
    );
  }
}
