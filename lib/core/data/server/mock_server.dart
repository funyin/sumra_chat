import 'dart:async';
import 'dart:math';

import 'package:sumra_chat/core/constants/app_gloabl_elements.dart';
import 'package:sumra_chat/models/item_chat_model.dart';

class MockServer {
  static List<ChatModel> get randomChats {
    var list = List.generate(30, (index) {
      var chatType = Random().nextBool() ? ChatType.private : ChatType.public;
      var isPrivate = chatType == ChatType.private;
      var participants = List.generate(
          isPrivate ? 2 : (Random().nextInt(10) + 2),
          (index) => isPrivate && index == 0
              ? signedInUser
              : randomUsers[Random().nextInt(randomUsers.length - 1)]);
      var randomMessages = _randomMessages(participants);
      return ChatModel(
          chatData: ChatData(
              created: faker.date.dateTime(),
              imageURl: Random().nextBool()
                  ? faker.image.image(width: 200, height: 200)
                  : null,
              description: faker.lorem.sentences(Random().nextInt(2)).join(" "),
              topic: faker.lorem.words(3).join(" "),
              admins: [participants[1]],

              ///If its private make the list have 2 participants, signed in user as first and participant as the second user
              participants: participants),
          chatId: "$index",
          chatType: chatType,
          messages: randomMessages,
          numOfNewMessage: randomMessages
              .where((element) => element.sender != signedInUser)
              .length);
    });

    list.sort((chat1, chat2) =>
        chat1.messages.last.date.compareTo(chat2.messages.last.date));
    return list.reversed.toList();
  }

  static List<ChatMessageModel> _randomMessages(List<UserModel> participants) {
    return List.generate(Random().nextInt(19) + 1, (index) {
      var dateTime = DateTime.now();
      var month = Random().nextInt(dateTime.month) + 1;

      var messageType = ChatMessageType
          .values[Random().nextInt(ChatMessageType.values.length - 1)];

      late String message;
      switch (messageType) {
        case ChatMessageType.text:
          message = faker.lorem.sentences(Random().nextInt(2) + 2).join();
          break;
        case ChatMessageType.image:
          message = faker.image.image(random: true);
          break;
      }

      return ChatMessageModel(
          date: DateTime(
              dateTime.year,
              month,
              Random().nextInt(month != dateTime.month ? 30 : dateTime.day),
              Random().nextInt(23),
              Random().nextInt(59)),
          messageType: messageType,
          message: message,
          sender: participants[Random().nextInt(participants.length)]);
    });
  }

  static UserModel _randomUser(int id) => UserModel(
      id: id,
      imageUrl: Random().nextBool()
          ? faker.image.image(
              width: 200,
              height: 200,
              keywords: ["person", "woman", "man", "boy", ",girl"],
              random: true)
          : null,
      status: MessageSenderStatus.offline,
      name: faker.person.name());

  static List<UserModel> randomUsers =
      List.generate(30, (index) => _randomUser(index + 1));

  static UserModel signedInUser = UserModel(
      id: 0,
      imageUrl: "https://avatars.githubusercontent.com/u/38915569?v=4",
      status: MessageSenderStatus.online,
      name: "Funyinoluwa Kashimawo");

  static Future<ChatMessageModel> generateResponse(
      ChatModel selectedChat) async {
    var private = selectedChat.chatType == ChatType.private;
    var groupMembers = selectedChat.chatData.participants
        .where((element) => element != signedInUser);
    var respondent = private
        ? selectedChat.chatData.participants[1]
        : groupMembers.elementAt(Random().nextInt(groupMembers.length - 1));
    respondent.status = MessageSenderStatus.typing;
    participantStatusController.add({selectedChat.chatId: respondent});
    await Future.delayed(Duration(seconds: Random().nextInt(4) + 2));
    respondent.status = MessageSenderStatus.offline;
    participantStatusController.add({selectedChat.chatId: respondent});
    if (private)
      return ChatMessageModel(
          sender: selectedChat.chatData.participants.first,
          date: DateTime.now(),
          message: faker.lorem.sentences(Random().nextBool() ? 1 : 2).join());
    else
      return ChatMessageModel(
          sender: respondent,
          date: DateTime.now(),
          message: faker.lorem.sentences(Random().nextBool() ? 1 : 2).join());
  }

  static StreamController<Map<String, UserModel>>
      get participantStatusController => StreamController();
}
