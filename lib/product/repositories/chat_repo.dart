import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {

    Future<void> sendMessage({required String receiverId, required String message}) async {}
    Future<void> deleteChat({required String receiverId});
    Future<void> addChatRoom(receiverId) async {}
    Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats();
    Stream<QuerySnapshot> getChat({required String receiverId});
}