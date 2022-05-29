import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/bloc/state.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/models/item_chat_model.dart';
import 'package:sumra_chat/presentation/widgets/list_items/chat_bubble.dart';

class ChatBody extends StatefulWidget {
  ChatBody(this.chat, {Key? key}) : super(key: key);

  final ChatModel chat;

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(const Duration(milliseconds: 200), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            Assets.imagesChatBackground,
            fit: BoxFit.cover,
          )),
          Positioned.fill(
              child: BlocConsumer<ChatsCubit, ChatsState>(
            listenWhen: buildCheck,
            bloc: BlocProvider.of<ChatsCubit>(context),
            buildWhen: buildCheck,
            listener: (context, state) {
              Timer(const Duration(milliseconds: 60), () {
                scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              });
            },
            builder: (context, state) {
              var messages = state.recentChats
                  .firstWhere((element) => element.chatId == widget.chat.chatId)
                  .messages;
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth / 40, vertical: 20)
                    .copyWith(top: 10),
                controller: scrollController,
                itemBuilder: (context, index) {
                  var message = messages[index];
                  return ChatBubble(
                      message: message,
                      nextMessage: message == messages.last
                          ? null
                          : messages[index + 1]);
                },
                itemCount: messages.length,
              );
            },
          )),
        ],
      );
    });
  }

  bool buildCheck(ChatsState previous, ChatsState current) {
    // return previous.recentChats
    //         .firstWhere((element) => element.chatId == chat.chatId)
    //         .messages !=
    //     current.recentChats
    //         .firstWhere((element) => element.chatId == chat.chatId)
    //         .messages;
    return previous.recentChats != current.recentChats;
  }
}
