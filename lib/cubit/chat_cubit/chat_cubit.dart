import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../product/repoImpl/chat_repo_impl.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final repository = ChatRepositoryImpl();
  ChatCubit() : super(ChatInitial()) {
    getAllChats();
  }

  void addChatRoom(receiverId) async {
    try {
      await repository.addChatRoom(receiverId);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Stream<QuerySnapshot> getAllChatss() {
    try {
      emit(ChatLoading());
      final chats = repository.getAllChats();
      emit(ChatLoaded(chats));

      
      return chats;
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void deleteChat(chatRoomId) async {
    try {
      await repository.deleteChat(chatRoomId: chatRoomId);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Stream<QuerySnapshot> getAllChats() {
    return repository.getAllChats();
  }
}