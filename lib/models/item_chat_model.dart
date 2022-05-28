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
  final UserModel? sender;
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

class UserModel {
  final int id;
  final String name;
  final String? imageUrl;
  MessageSenderStatus status;

  UserModel(
      {required this.id,
      this.name = "No name",
      this.imageUrl,
      this.status = MessageSenderStatus.offline});
}

enum MessageSenderStatus { offline, online, typing }

enum ChatType { public, private }

class ChatData {
  final String topic;
  final String description;
  final String? imageURl;
  final List<UserModel>? admins;

  ///for private chats the respondent is the first element while the signed in user is the second
  final List<UserModel> participants;
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
