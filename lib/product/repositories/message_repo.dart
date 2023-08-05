import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessageRepository {
  Future<void> sendMessage({required String receiverId, required String message}) async {}
  Stream<QuerySnapshot> getChat({required String chatRoomId});

}