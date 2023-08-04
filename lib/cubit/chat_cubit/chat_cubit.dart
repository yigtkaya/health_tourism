import 'package:bloc/bloc.dart';

import '../../product/repoImpl/chat_repo_impl.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final repository = ChatRepositoryImpl();
  ChatCubit() : super(ChatInitial());

}