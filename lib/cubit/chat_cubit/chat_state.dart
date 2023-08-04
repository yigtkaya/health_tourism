import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);

  @override
  List<Object> get props => [message];
}