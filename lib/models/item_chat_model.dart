import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final List<ChatMessageModel> messages;
  final ChatData chatData;
  final String chatId;
  String draft;
  late int numOfNewMessage;

  ChatModel(
      {required this.messages,
      this.numOfNewMessage = 0,
      required this.chatData,
      required this.chatId,
      this.draft = ""});

  ChatModel copyWith({
    List<ChatMessageModel>? messages,
    ChatData? chatData,
    String? chatId,
    String? draft,
    int? numOfNewMessage,
  }) {
    return ChatModel(
      messages: messages ?? this.messages,
      chatData: chatData ?? this.chatData,
      chatId: chatId ?? this.chatId,
      draft: draft ?? this.draft,
      numOfNewMessage: numOfNewMessage ?? this.numOfNewMessage,
    );
  }

  @override
  List<Object> get props => [
        [...messages],
        chatData,
        chatId
      ];
}

class ChatMessageModel {
  final UserModel sender;
  final String message;
  final ChatMessageType messageType;
  final DateTime time;
  final bool read;

  ChatMessageModel(
      {required this.sender,
      required this.message,
      this.messageType = ChatMessageType.text,
      required this.time,
      this.read = false});

  String get id => message + time.toIso8601String();

  ChatMessageModel copyWith({
    UserModel? sender,
    String? message,
    ChatMessageType? messageType,
    DateTime? time,
    bool? read,
  }) {
    return ChatMessageModel(
      sender: sender ?? this.sender,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
      time: time ?? this.time,
      read: read ?? this.read,
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String imageUrl;
  MessageSenderStatus status;
  DateTime lastActive;
  final bool hasStory;

  UserModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      this.status = MessageSenderStatus.offline,
      required this.lastActive,
      required this.hasStory});

  late bool recentlyActive =
      DateTime.now().difference(lastActive).inMinutes <= 10;
  late bool active = DateTime.now().difference(lastActive).inMinutes <= 1 ||
      status == MessageSenderStatus.typing;
}

enum MessageSenderStatus { offline, online, typing }

class ChatData {
  ///The respondent is the first element while the signed in user is the second
  final List<UserModel> participants;

  ChatData({
    required this.participants,
  });
}

enum ChatMessageType { text, image }
