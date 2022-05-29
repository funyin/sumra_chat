import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/data/server/mock_server.dart';
import 'package:sumra_chat/generated/assets.dart';
import 'package:sumra_chat/models/item_chat_model.dart';
import 'package:sumra_chat/presentation/widgets/app_fade_in_image.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessageModel message;
  final ChatMessageModel? nextMessage;

  ChatBubble({Key? key, required this.message, this.nextMessage})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  late UserModel messageSender = widget.message.sender;

  late bool iSent = messageSender == MockServer.signedInUser;

  @override
  Widget build(BuildContext context) {
    var headerStyle = const TextStyle(
        fontSize: 12.8, color: Colors.black26, fontWeight: FontWeight.w200);
    var bottomMargin = widget.nextMessage == null ||
            widget.nextMessage!.sender == messageSender
        ? 2.0
        : 10.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        var messageType = widget.message.messageType;
        var textMessage = messageType == ChatMessageType.text;
        var image = messageType == ChatMessageType.image;
        var borderRadius = BorderRadius.circular(18).copyWith(
            bottomLeft: Radius.circular(iSent ? 18 : 0),
            bottomRight: Radius.circular(iSent ? 0 : 18));
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              iSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(intl.DateFormat.jm().format(widget.message.time),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.3))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: bottomMargin,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                textDirection: iSent ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  senderIdentity(headerStyle),
                  Flexible(
                      child: Container(
                    padding: textMessage
                        ? const EdgeInsets.only(
                            top: 6, right: 7, bottom: 8, left: 9)
                        : const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: iSent
                            ? AppColors.blue
                            : Colors.black.withOpacity(0.06),
                        borderRadius: borderRadius),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: iSent
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (textMessage)
                          Flexible(
                            child: Text(
                              widget.message.message,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: iSent ? Colors.white : null),
                            ),
                          ),
                        if (image)
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: 246, minHeight: 100),
                            child: ClipRRect(
                              borderRadius: borderRadius,
                              child:
                                  AppFadeInImage(url: widget.message.message),
                            ),
                          ),
                      ],
                    ),
                  )),
                  SizedBox(width: constraints.maxWidth * 0.256)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Padding senderIdentity(TextStyle headerStyle) {
    var read = widget.message.read;
    return Padding(
      padding: EdgeInsets.only(right: iSent ? 0 : 8, left: iSent ? 8 : 0),
      child: iSent
          ? SvgPicture.asset(
              read ? Assets.vectorsIcCheckTrue : Assets.vectorsIcCheckFalse,
              color: read ? AppColors.blue : AppColors.iconColorInactive,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                height: 28,
                width: 28,
                child: AppFadeInImage(
                  url: messageSender.imageUrl,
                ),
              ),
            ),
    );
  }
}
