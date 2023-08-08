import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/cubit/message/message_state.dart';
import 'package:health_tourism/product/repoImpl/message_repo_impl.dart';

import '../../product/models/message.dart';

class MessageCubit extends Cubit<MessageState> {
  final repository = MessageRepositoryImpl();

  MessageCubit() : super(MessageInitial());

  void sendMessage(
       String receiverId, String message, String? imageUrl) async {
    try {
        await repository.sendMessage(receiverId: receiverId, message: message, imageUrl: imageUrl);
    } catch (e) {
      emit(MessageSentError(e.toString()));
    }
  }

  void getChat({required String chatRoomId}) {
    emit(MessageLoading());
    Future.value(repository.getChat(chatRoomId: chatRoomId))
        .then((value) => emit(MessageLoaded(value)))
        .onError((error, stackTrace) =>
            {emit(MessageError(error.toString())), print(error.toString())});
  }

  void sendImage (File file, String message) {

  }
}
