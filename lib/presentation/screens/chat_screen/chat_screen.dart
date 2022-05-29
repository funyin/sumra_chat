import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/models/item_chat_model.dart';
import 'package:sumra_chat/presentation/screens/chat_screen/chat_appbar.dart';
import 'package:sumra_chat/presentation/screens/chat_screen/chat_body.dart';
import 'package:sumra_chat/presentation/screens/chat_screen/message_builder.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ChatAppBar(widget.chat),
        Expanded(child: ChatBody(widget.chat)),
        MessageBuilder(widget.chat)
      ],
    ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var cubit = BlocProvider.of<ChatsCubit>(context);
      var chatId = widget.chat.chatId;
      cubit.selectChat(chatId);
      cubit.viewRespondentsMessages(chatId);
    });
  }

  @override
  void dispose() {
    var cubit = BlocProvider.of<ChatsCubit>(context);
    cubit.selectChat(null);
    super.dispose();
  }
}
