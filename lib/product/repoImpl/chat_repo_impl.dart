
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/product/repositories/chat_repo.dart';

class ChatRepositoryImpl extends ChatRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> deleteAllChats() {
    // TODO: implement deleteAllChats
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllMessages({required String chatId}) {
    // TODO: implement deleteAllMessages
    throw UnimplementedError();
  }

  @override
  Future<void> deleteChat({required String chatId}) {
    // TODO: implement deleteChat
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMessage({required String chatId, required String messageId}) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  Stream<List<Map<String, dynamic>>> getMessages({required String chatId}) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage({required String chatId, required String message}) async {
    // get current user
    final currentUser = _auth.currentUser?.uid;
    final currentUserId = _auth.currentUser?.displayName;


  }



}