import 'package:flutter/material.dart';

class ChatModel {
  final List<ChatMessageModel> messages;
  final ChatType chatType;
  final ChatData chatData;
  final String chatId;
  String draft;
  late int numOfNewMessage;

  ChatModel(
      {required this.messages,
      this.numOfNewMessage = 0,
      required this.chatType,
      required this.chatData,
      required this.chatId,
      this.draft = ""}) {}
}

class ChatMessageModel {
  final MessageSender? sender;
  final String message;
  final ChatMessageType messageType;
  final DateTime date;

  ChatMessageModel(
      {this.sender,
      required this.message,
      this.messageType = ChatMessageType.text,
      required this.date});

  String get id => message + date.toIso8601String();
}

class MessageSender {
  final String name;
  final String? mobile;
  final String? about;
  final String? imageUrl;
  final Color? color;
  final bool? savedContact;
  MessageSenderStatus status;

  MessageSender(
      {this.name = "No name",
      this.mobile,
      this.imageUrl,
      this.about,
      this.color,
      this.savedContact,
      this.status = MessageSenderStatus.offline});
}

enum MessageSenderStatus { offline, online, typing, recording }

enum ChatType { public, private }

class ChatData {
  final String topic;
  final String description;
  final String? imageURl;
  final List<MessageSender>? admins;

  ///for private chats the respondent is the first element while the signed in user is the second
  final List<MessageSender> participants;
  final DateTime created;
  final noGroupDpSvg =
      "https://firebasestorage.googleapis.com/v0/b/funyinkash-portfolio.appspot.com/o/portfolio%2FwhatsAppClone%2Fimages%2FnoGroupDpSvg.svg?alt=media&token=265c0ff0-4a77-4f3c-8884-82adfafd7226";

  ChatData({
    required this.topic,
    this.imageURl,
    this.admins,
    required this.participants,
    required this.description,
    required this.created,
  });
}

enum ChatMessageType { text, image }
