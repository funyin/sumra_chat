import 'package:equatable/equatable.dart';
import 'package:sumra_chat/models/item_chat_model.dart';

class ChatsState extends Equatable {
  final String? selectedChatId;
  final String? lastSelectedChatId;
  List<ChatModel> recentChats;
  final List<UserModel> respondents;
  final UserModel signedInUser;

  ChatsState(
      {this.selectedChatId,
      this.lastSelectedChatId,
      required this.recentChats,
      required this.signedInUser,
      required this.respondents});

  ChatsState copyWith({
    String? selectedChatId,
    String? lastSelectedChatId,
    List<ChatModel>? recentChats,
    List<UserModel>? respondents,
    UserModel? signedInUser,
  }) {
    return ChatsState(
      selectedChatId: selectedChatId ?? this.selectedChatId,
      lastSelectedChatId: lastSelectedChatId ?? this.lastSelectedChatId,
      recentChats: recentChats ?? this.recentChats,
      respondents: respondents ?? this.respondents,
      signedInUser: signedInUser ?? this.signedInUser,
    );
  }

  @override
  List<Object?> get props => [
        selectedChatId,
        lastSelectedChatId,
        [...recentChats],
        respondents,
        signedInUser,
      ];
}
