import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_tourism/product/repositories/message_repo.dart';
import '../models/message.dart';
import 'package:path/path.dart' as Path;

class MessageRepositoryImpl extends MessageRepository {
  final _firestore = FirebaseFirestore.instance;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  String listJoiner(String receiverId) {
    List<String> ids = [currentUserId, receiverId];
    String chatRoomId = ids.join('_');
    return chatRoomId;
  }

  @override
  Future<void> sendMessage(
      {required String receiverId, required String message, String? imageUrl}) async {
    try {
      if(imageUrl == null) {
        Message msg = Message(
          senderId: currentUserId,
          receiverId: receiverId,
          message: message,
          messageTime: Timestamp.now(),
        );

        final lastmsg = {
          "lastMessageTime": msg.messageTime,
          "message": msg.message,
          "senderId": msg.senderId
        };
        final chatRoomId = listJoiner(receiverId);

        await _firestore
            .collection('chatRooms')
            .doc(chatRoomId)
            .collection('messages')
            .add(msg.toMap());

        // update last message
        await _firestore.collection('chatRooms').doc(chatRoomId).set({
          "lastMessage": lastmsg,
          'ids': [currentUserId, receiverId]
        });
      }
       else {
        Message msg = Message(
          senderId: currentUserId,
          receiverId: receiverId,
          message: message,
          imageUrl: imageUrl,
          messageTime: Timestamp.now(),
        );

        final lastmsg = {
          "lastMessageTime": msg.messageTime,
          "message": msg.message,
          "senderId": msg.senderId
        };

        final chatRoomId = listJoiner(receiverId);

        await _firestore
            .collection('chatRooms')
            .doc(chatRoomId)
            .collection('messages')
            .add(msg.toMap());

        // update last message
        await _firestore.collection('chatRooms').doc(chatRoomId).set({
          "lastMessage": lastmsg,
          'ids': [currentUserId, receiverId]
        });
      }
    } catch (e) {
      showToastMessage(message: e.toString());
    }
  }

  @override
  Stream<QuerySnapshot> getChat({required String chatRoomId}) {
    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('messageTime', descending: false)
        .snapshots();
  }

  Future<String> uploadImageToFirebase(File file, String chatRoomId) async {
    String fileUrl = '';
      String fileName = Path.basename(file.path);
      var reference =
          FirebaseStorage.instance.ref().child('chatImages/$chatRoomId/$fileName');
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      await taskSnapshot.ref
          .getDownloadURL()
          .then((value) => {fileUrl = value});

    print('URL: $fileUrl');
    return fileUrl;
  }

  @override
  Future<void> sendImageMessage(File file, String message) async {

  }

  showToastMessage({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
