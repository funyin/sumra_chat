import 'dart:async';
import 'dart:math';

import 'package:sumra_chat/core/constants/app_gloabl_elements.dart';
import 'package:sumra_chat/models/item_chat_model.dart';

class MockServer {
  static List<ChatModel> randomChats(List<UserModel> users) {
    var list = List.generate(users.length ~/ 2, (index) {
      var participants = List.generate(
          2, (index) => index == 0 ? signedInUser : _randomUser(index));
      var randomMessages = _randomMessages(participants);
      randomMessages.sort((a, b) => a.time.compareTo(b.time));
      return ChatModel(
          chatData: ChatData(

              ///Make the list have 2 participants, signed in user as first and participant as the second user
              participants: participants),
          chatId: "$index",
          messages: randomMessages,
          numOfNewMessage:
              randomMessages.where((t) => t.sender != signedInUser).length);
    });

    list.sort((chat1, chat2) =>
        chat1.messages.last.time.compareTo(chat2.messages.last.time));
    return list.reversed.toList();
  }

  static List<ChatMessageModel> _randomMessages(List<UserModel> participants) {
    var random = Random();
    var readAllRespondentsMessages = random.nextBool();
    return List.generate(Random().nextInt(19) + 1, (index) {
      var dateTime = DateTime.now();
      var month = random.nextInt(dateTime.month) + 1;
      var messageType = ChatMessageType
          .values[random.nextInt(ChatMessageType.values.length - 1)];
      late String message;
      switch (messageType) {
        case ChatMessageType.text:
          message = faker.lorem.sentences(random.nextInt(2) + 1).join();
          break;
        case ChatMessageType.image:
          message = faker.image.image(random: true);
          break;
      }
      var participant = participants[random.nextInt(participants.length)];
      return ChatMessageModel(
          time: DateTime(
              dateTime.year,
              month,
              random.nextInt(month != dateTime.month ? 30 : dateTime.day),
              random.nextInt(23),
              random.nextInt(59)),
          messageType: messageType,
          message: message,
          read: participant.id == participants.first.id
              ? true
              : readAllRespondentsMessages,
          sender: participant);
    });
  }

  static UserModel _randomUser(int id) => UserModel(
      id: id,
      imageUrl: faker.image.image(
          width: 150,
          height: 150,
          keywords: ["person", "woman", "man", "boy", ",girl"],
          random: true),
      status: MessageSenderStatus.offline,
      name: faker.person.name(),
      lastActive:
          DateTime.now().subtract(Duration(minutes: Random().nextInt(1000))),
      hasStory: Random().nextBool());

  static List<UserModel> randomUsers = List.generate(30, (index) {
    return _randomUser(index + 1);
  });

  static UserModel signedInUser = UserModel(
      id: 0,
      imageUrl: "https://avatars.githubusercontent.com/u/38915569?v=4",
      status: MessageSenderStatus.online,
      name: "Funyinoluwa Kashimawo",
      lastActive: DateTime.now(),
      hasStory: true);

  static Future<ChatMessageModel> generateResponse(
      ChatModel selectedChat) async {
    var respondent = selectedChat.chatData.participants.last;
    respondent.status = MessageSenderStatus.typing;
    respondent.lastActive = DateTime.now();
    participantStatusController.add({selectedChat.chatId: respondent});
    // await Future.delayed(Duration(seconds: Random().nextInt(3) + 2));
    respondent.status = MessageSenderStatus.offline;
    participantStatusController.add({selectedChat.chatId: respondent});
    return ChatMessageModel(
        sender: respondent,
        time: DateTime.now(),
        message: faker.lorem.sentences(Random().nextBool() ? 1 : 2).join());
  }

  static StreamController<Map<String, UserModel>>
      get participantStatusController => StreamController();
}
