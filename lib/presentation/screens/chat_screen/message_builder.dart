import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/models/item_chat_model.dart';

class MessageBuilder extends StatefulWidget {
  MessageBuilder(this.chat, {Key? key}) : super(key: key);
  ChatModel chat;

  @override
  State<MessageBuilder> createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  late final messageController = TextEditingController(text: widget.chat.draft);

  final typing = ValueNotifier(false);

  late ChatsCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of<ChatsCubit>(context);
    return Container(
      height: 52,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => chatActions[index],
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemCount: chatActions.length),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: TextField(
                    expands: false,
                    textInputAction: TextInputAction.send,
                    style: const TextStyle(fontSize: 17),
                    controller: messageController,
                    onSubmitted: (value) => sendMessage(context),
                    onChanged: (value) {
                      typing.value = value.isNotEmpty;
                      widget.chat.draft = value;
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.black.withOpacity(0.05),
                        filled: true,
                        hintText: "Aa",
                        hintStyle:
                            const TextStyle(color: const Color(0xff999999)),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.all(6).copyWith(left: 16),
                        isDense: true,
                        suffixIcon: SizedBox(
                          width: 20,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.vectorsIcEmoji,
                              height: 24,
                              color: AppColors.grey6,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: typing,
              builder: (context, value, child) {
                return actionIcon(Assets.vectorsIcThumbUp,
                    active: value, onTap: () => sendMessage(context));
              })
        ],
      ),
    );
  }

  late var chatActions = [
    actionIcon(Assets.vectorsIcActions, active: true),
    actionIcon(Assets.vectorsIcCamera),
    actionIcon(Assets.vectorsIcImage),
    actionIcon(Assets.vectorsIcMicrophone),
  ];

  Widget actionIcon(String icon, {bool active = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        icon,
        width: 24,
        color: active ? AppColors.blue : AppColors.grey6,
      ),
    );
  }

  Future<void> sendMessage(BuildContext context) async {
    var text = messageController.text;
    if (text.isNotEmpty) {
      final message = ChatMessageModel(
          time: DateTime.now(),
          message: text,
          sender: widget.chat.chatData.participants.first);
      await cubit.addMessage(message, widget.chat.chatId);
      messageController.clear();
      typing.value = false;
      await cubit.awaitResponse(widget.chat.chatId);
    }
  }
}
