import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/product/models/user.dart';
import 'package:health_tourism/product/repositories/chat_repo.dart';

import '../models/message.dart';

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
  Future<String> addChatRoom(receiverId, clinicName, customerName) async {
    final chatRoomId = listJoiner(receiverId);

    final data = await _firestore.collection("chats").doc(chatRoomId).get();

    if(!data.exists) {
      await _firestore.collection("chats")
          .doc(chatRoomId)
          .set({
        "ids": [currentUserId, receiverId],
        "names" : [clinicName, customerName],
        "messages": [],
      });
    }

    return chatRoomId;
  }

  @override
  Stream<QuerySnapshot> getAllChats() {
    return _firestore.collection("chats")
        .where("ids", arrayContains: currentUserId).snapshots();
  }

  @override
  Future<void> deleteChat({required String chatRoomId}) async {
    await _firestore.collection('chatRooms').doc(chatRoomId).delete();
  }
}