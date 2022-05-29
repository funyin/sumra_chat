import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/bloc/state.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/models/item_chat_model.dart';
import 'package:sumra_chat/presentation/widgets/user_dp.dart';

class ChatAppBar extends StatelessWidget {
  ChatAppBar(this.chat, {Key? key}) : super(key: key);
  final ChatModel chat;
  late var respondent = chat.chatData.participants.last;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: 58,
        child: BlocBuilder<ChatsCubit, ChatsState>(
          builder: (context, state) {
            var respondent = BlocProvider.of<ChatsCubit>(context)
                .selectedChat()
                .chatData
                .participants
                .last;
            return Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(right: 14),
                    child: SvgPicture.asset(
                      Assets.vectorsIcBack,
                      color: AppColors.blue,
                      height: 22,
                    ),
                  ),
                ),
                UserDp(size: 36, user: respondent),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          respondent.name,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.neutralDark),
                        ),
                        Text(
                          respondent.status.name.toLowerCase(),
                          style: const TextStyle(
                              color: AppColors.offBlack,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                appBarIcon(Assets.vectorsIcPhone),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: appBarIcon(Assets.vectorsIcVideo),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  SvgPicture appBarIcon(String icon) {
    return SvgPicture.asset(
      icon,
      height: 24,
      color: AppColors.blue,
    );
  }
}
