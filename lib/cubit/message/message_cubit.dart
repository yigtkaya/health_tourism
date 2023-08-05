import 'package:bloc/bloc.dart';
import 'package:health_tourism/cubit/message/message_state.dart';
import 'package:health_tourism/product/repoImpl/message_repo_impl.dart';

import '../../product/models/message.dart';

class MessageCubit extends Cubit<MessageState> {
  final repository = MessageRepositoryImpl();

  MessageCubit() : super(MessageInitial());

  void sendMessage(
      {required String receiverId, required String message}) async {
    try {
      await repository.sendMessage(receiverId: receiverId, message: message);
      emit(MessageSent());
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  void getChat({required String chatRoomId}) {
    emit(MessageLoading());
    Future.value(repository.getChat(chatRoomId: chatRoomId))
        .then((value) => emit(MessageLoaded(value)))
        .onError((error, stackTrace) => {
              emit(MessageError(stackTrace.toString())),
      print(error.toString())
    });
  }
}
