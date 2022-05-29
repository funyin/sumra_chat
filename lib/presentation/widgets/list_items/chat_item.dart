import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/models/item_chat_model.dart';
import 'package:sumra_chat/presentation/routes/app_routers.dart';
import 'package:sumra_chat/presentation/widgets/user_dp.dart';

class ChatItem extends StatelessWidget {
  final ChatModel chat;
  late var respondent = chat.chatData.participants.last;

  ChatItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(color: AppColors.grey4);
    var lastMessage = chat.messages.last;
    var signedInUser = chat.chatData.participants.first;
    return InkWell(
      onTap: () {
        var cubit = BlocProvider.of<ChatsCubit>(context);
        cubit.selectChat(chat.chatId);
        Navigator.pushNamed(context, AppRoutes.chat, arguments: chat);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserDp(size: 60, user: respondent),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      respondent.name,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          "${lastMessage.sender.id == signedInUser.id ? "You : " : ""}${lastMessage.message.length > 16 ? "${lastMessage.message.substring(0, 12)}.." : lastMessage.message}",
                          maxLines: 2,
                          style: textStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child:
                              Text("•", style: textStyle.copyWith(fontSize: 6)),
                        ),
                        Text(
                          DateFormat(DateFormat.HOUR_MINUTE)
                              .format(lastMessage.time)
                              .toUpperCase(),
                          style: textStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              chat.messages.last.read
                  ? Assets.vectorsIcCheckTrue
                  : Assets.vectorsIcCheckFalse,
              width: 16,
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
