import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/product/repositories/chat_repo.dart';

class ChatRepositoryImpl extends ChatRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  String listJoiner (String receiverId) {
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return chatRoomId;
  }

  @override
  Future<void> addChatRoom(receiverId) async {
    final chatRoomId = listJoiner(receiverId);

    await _firestore.collection("chatRooms")
        .doc(chatRoomId)
    .set({
      "ids": [currentUserId, receiverId],
      "chatRoomId": chatRoomId,
    });
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChats() {
    return  _firestore.collection("chatRooms")
        .where("ids", arrayContains: currentUserId)
        .orderBy("timestamp", descending: false)
        .snapshots();
    }

  @override
  Future<void> deleteChat({required String chatRoomId}) async {
    // TODO: implement deleteChat
    await _firestore.collection('chatRooms').doc(chatRoomId).delete();
  }
}