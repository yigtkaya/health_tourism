import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {

    Future<void> deleteChat({required String chatRoomId});
    Future<void> addChatRoom(receiverId) async {}
    Stream<QuerySnapshot> getAllChats();
}