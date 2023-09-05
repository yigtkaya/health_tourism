
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class MessageInitial extends MessageState {
  @override
  List<Object?> get props => [];
}

class MessageLoading extends MessageState {
  @override
  List<Object?> get props => [];
}

class MessageLoaded extends MessageState {
  final Stream<DocumentSnapshot> chatDocument;

  MessageLoaded(this.chatDocument,);
}

class MessageSentError extends MessageState {
  final String message;

  MessageSentError(this.message);

  @override
  List<Object?> get props => [message];
}

class MessageError extends MessageState {
  final String message;

  MessageError(this.message);

  @override
  List<Object?> get props => [message];
}
