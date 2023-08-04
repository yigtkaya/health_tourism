import 'package:bloc/bloc.dart';
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

  void getAllChats() {
    try {
      emit(ChatLoading());
      Future.value(repository.getAllChats())
          .then((value) => emit(ChatLoaded(value)));
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

  String formatDate (DateTime date) {
    // if date is today return time only else return date only
    if (date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year) {
      return "${date.hour}:${date.minute}";
    } else if (date.day == DateTime.now().day - 1 && date.month == DateTime.now().month && date.year == DateTime.now().year) {
      return "Yesterday";
    }
    else {
      return "${date.day}.${date.month}.${date.year}";
    }
  }
}
