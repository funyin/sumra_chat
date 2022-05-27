import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/data/server/mock_server.dart';
import 'package:sumra_chat/models/item_chat_model.dart';
import 'package:sumra_chat/presentation/widgets/app_fade_in_image.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessageModel message;
  final ChatType? chatType;
  final ChatMessageModel? nextMessage;

  ChatBubble({Key? key, required this.message, this.chatType, this.nextMessage})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final hovering = ValueNotifier(false);

  late MessageSender messageSender = widget.message.sender!;

  late bool iSent = messageSender == MockServer.signedInUser;

  @override
  Widget build(BuildContext context) {
    var headerStyle = TextStyle(
        fontSize: 12.8, color: Colors.black26, fontWeight: FontWeight.w200);
    var bottomMargin = widget.nextMessage == null ||
            widget.nextMessage!.sender == messageSender
        ? 2.0
        : 10.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        var transform = Matrix4.rotationY(iSent ? pi : 0)
          ..translate(iSent ? -8 : 0);
        var messageType = widget.message.messageType;
        var textMessage = messageType == ChatMessageType.text;
        var image = messageType == ChatMessageType.image;
        var borderRadius = BorderRadius.circular(8).copyWith(
            topLeft: Radius.circular(iSent ? 8 : 0),
            topRight: Radius.circular(iSent ? 0 : 8));
        return MouseRegion(
          onEnter: (_) => hovering.value = true,
          onExit: (_) => hovering.value = false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            textDirection: iSent ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Flexible(
                  child: Stack(
                children: [
                  Container(
                    padding: textMessage
                        ? EdgeInsets.only(top: 6, right: 7, bottom: 8, left: 9)
                        : EdgeInsets.all(3),
                    margin: EdgeInsets.only(
                      bottom: bottomMargin,
                    ),
                    decoration: BoxDecoration(
                        color: iSent ? AppColors.purple : Colors.white,
                        borderRadius: borderRadius),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: iSent
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (widget.chatType == ChatType.public &&
                            messageSender != MockServer.signedInUser)
                          senderIdentity(headerStyle),
                        if (textMessage)
                          Flexible(
                            child: Text(
                              "${widget.message.message}                \u{2063}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14),
                            ),
                          ),
                        if (image)
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: 246, minHeight: 100),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child:
                                  AppFadeInImage(url: widget.message.message),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: bottomMargin + 6,
                    right: 10,
                    child: time(image),
                  )
                ],
              )),
              SizedBox(width: constraints.maxWidth / 2.83)
            ],
          ),
        );
      },
    );
  }

  Padding senderIdentity(TextStyle headerStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (!messageSender.savedContact!)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              "${messageSender.mobile}",
              style: headerStyle.copyWith(color: messageSender.color),
            ),
          ),
        Text(
          (!messageSender.savedContact! ? "~ " : "") + messageSender.name,
          style: headerStyle.copyWith(
              color: messageSender.savedContact! ? messageSender.color : null),
        ),
      ]),
    );
  }

  Text time([bool white = false]) {
    return Text(intl.DateFormat.jm().format(widget.message.date),
        style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w200,
            color: white ? Colors.white : Colors.black26));
  }

  ValueListenableBuilder<bool> bubbleActions() {
    return ValueListenableBuilder<bool>(
      valueListenable: hovering,
      builder: (context, hovering, child) => AnimatedPositioned(
          right: hovering ? 0 : -30,
          duration: const Duration(milliseconds: 200),
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                (iSent ? AppColors.senderColor : Colors.white).withOpacity(0.4),
                (iSent ? AppColors.senderColor : Colors.white),
                (iSent ? AppColors.senderColor : Colors.white),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.purple,
              ),
            ),
          )),
    );
  }
}
