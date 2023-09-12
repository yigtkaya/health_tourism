import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {

    Future<void> deleteChat({required String chatRoomId});
    Future<String> addChatRoom(receiverId,clinicName, customerName) async {
        return "";
    }
    Stream<QuerySnapshot> getAllChats();
}