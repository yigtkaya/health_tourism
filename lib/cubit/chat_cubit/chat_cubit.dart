import 'package:bloc/bloc.dart';

import '../../product/repoImpl/chat_repo_impl.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final repository = ChatRepositoryImpl();
  ChatCubit() : super(ChatInitial());

  void addChatRoom(receiverId) async {
    try {
      await repository.addChatRoom(receiverId);
      emit(ChatRoomAdded());
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void getAllChats() async {
    try {
      emit(ChatLoading());
      final chats = repository.getAllChats();
      emit(ChatLoaded(chats));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void deleteChat(chatRoomId) async {
    try {
      await repository.deleteChat(chatRoomId: chatRoomId);
      emit(ChatDeleted());
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }


}