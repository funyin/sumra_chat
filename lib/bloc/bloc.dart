import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumra_chat/bloc/state.dart';
import 'package:sumra_chat/core/data/server/mock_server.dart';
import 'package:sumra_chat/models/item_chat_model.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(ChatsState initialState) : super(initialState) {
    MockServer.participantStatusController.stream.listen(_listenToServer);
  }

  void _listenToServer(Map<String, UserModel> event) {
    var newState = state;
    var respondent = event.values.first;
    // newState.randomChats!
    //     .chatData.participants.elementAt(index).status = respondent.status;
    newState.recentChats
        .firstWhere((element) => element.chatId == event.keys.first)
        .chatData
        .participants
        .firstWhere((element) => element.id == respondent.id)
        .status = respondent.status;
    emit(newState);
  }

  selectChat(String? chatId) {
    var newState = state.copyWith(selectedChatId: chatId);
    newState.recentChats
        .firstWhere((element) => element.chatId == chatId)
        .numOfNewMessage = 0;
    emit(newState);
  }

  Future<void> addMessage(ChatMessageModel message, String chatId) async {
    var newState = state;
    var test = (element) => element.chatId == chatId;
    newState.recentChats.firstWhere(test).messages.add(message);
    newState.recentChats.firstWhere(test).draft = "";
    newState.recentChats.sort((chat1, chat2) =>
        chat1.messages.last.time.compareTo(chat2.messages.last.time));
    newState.recentChats = newState.recentChats.reversed.toList();
    emit(newState);
    return;
  }

  Future<void> awaitResponse(String chatId) async {
    await respondentViewedLastMessage(chatId);
    var response = await MockServer.generateResponse(selectedChat());
    await addMessage(response, chatId);
    return;
  }

  Future<void> respondentViewedLastMessage(String chatId) async {
    var newState = state;
    var mSelectedChat = selectedChat();
    var mMessages = mSelectedChat.messages;
    if (mMessages.isNotEmpty) {
      mMessages[mMessages.length - 1] = mMessages.last.copyWith(read: true);
    }
    newState.recentChats[selectedChatIndex()] =
        mSelectedChat.copyWith(messages: mMessages);
    emit(newState);
  }

  Future<void> viewRespondentsMessages(String chatId) async {
    var newState = state;
    var mSelectedChat = selectedChat();
    var mMessages = mSelectedChat.messages;
    mMessages.forEach((element) {
      var index = mMessages.indexOf(element);
      if (element.sender.id == mSelectedChat.chatData.participants.last)
        mMessages[index] = element.copyWith(read: true);
    });
    emit(newState);
  }

  UserModel respondent() => selectedChat().chatData.participants[1];

  ChatModel selectedChat() => state.recentChats
      .firstWhere((element) => element.chatId == state.selectedChatId);
  int selectedChatIndex() => state.recentChats
      .indexWhere((element) => element.chatId == state.selectedChatId);
}
