import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumra_chat/models/item_chat_model.dart';

import '../core/data/server/mock_server.dart';
import 'state.dart';

class WhatsAppCloneCubit extends Cubit<WhatsAppCloneState> {
  WhatsAppCloneCubit(WhatsAppCloneState initialState) : super(initialState) {
    MockServer.participantStatusController.stream.listen(_listenToServer);
  }

  void _listenToServer(Map<String, MessageSender> event) {
    var newState = state;
    var respondent = event.values.first;
    // newState.randomChats!
    //     .chatData.participants.elementAt(index).status = respondent.status;
    newState.randomChats!
        .firstWhere((element) => element.chatId == event.keys.first)
        .chatData
        .participants
        .firstWhere((element) => element.mobile == respondent.mobile)
        .status = respondent.status;
    emit(newState);
  }

  selectChat(String chatId) {
    var newState = WhatsAppCloneState(
        selectedChatId: chatId, randomChats: state.randomChats);
    newState.randomChats!
        .firstWhere((element) => element.chatId == chatId)
        .numOfNewMessage = 0;
    emit(newState);
  }

  Future<void> addMessage(ChatMessageModel message, String chatId) async {
    var newState = WhatsAppCloneState(
        selectedChatId: state.selectedChatId,
        randomChats: state.randomChats,
        activeDetail: state.activeDetail);
    var test = (element) => element.chatId == chatId;
    newState.randomChats!.firstWhere(test).messages.add(message);
    newState.randomChats!.firstWhere(test).draft = "";
    newState.randomChats!.sort((chat1, chat2) =>
        chat1.messages.last.date.compareTo(chat2.messages.last.date));
    newState.randomChats = newState.randomChats!.reversed.toList();
    emit(newState);
    return;
  }

  Future<void> awaitResponse(String chatId) async {
    var response = await MockServer.generateResponse(selectedChat());
    await addMessage(response, chatId);
    return;
  }

  setActiveDetail(ActiveDetail? detail) {
    var newState = WhatsAppCloneState(
        randomChats: state.randomChats,
        activeDetail: detail,
        selectedChatId: state.selectedChatId);
    emit(newState);
  }

  List<ChatModel> groupsInCommon() {
    return state.randomChats!
        .where((element) =>
            element.chatData.participants.contains(respondent()) &&
            element.chatData.participants.contains(MockServer.signedInUser) &&
            element.chatType == ChatType.public)
        .toList();
  }

  MessageSender respondent() => selectedChat().chatData.participants[1];

  ChatModel selectedChat() => state.randomChats!
      .firstWhere((element) => element.chatId == state.selectedChatId);
}
