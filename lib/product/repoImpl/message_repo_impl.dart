
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/product/repositories/message_repo.dart';
import '../models/message.dart';
import '../models/message_type.dart';

class MessageRepositoryImpl extends MessageRepository {

  final _firestore = FirebaseFirestore.instance;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  String listJoiner (String receiverId) {
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return chatRoomId;
  }

  @override
  Future<void> sendMessage({required String receiverId, required String message}) async {

    Message msg = Message(
      senderId: currentUserId,
      receiverId: receiverId,
      message: message,
      timestamp: Timestamp.now(),
      type: MessageType.text,
    );

    final chatRoomId = listJoiner(receiverId);

    await _firestore.collection('chatRooms').doc(chatRoomId)
        .collection('messages').add(msg.toMap());

  }

  @override
  Stream<QuerySnapshot> getChat({required String receiverId}) {
    final chatRoomId = listJoiner(receiverId);

    return _firestore.collection('chatRooms').doc(chatRoomId)
        .collection('messages').orderBy('timestamp', descending: false).snapshots();
  }

  @override
  Future<void> deleteChat({required String chatRoomId}) async {
    // TODO: implement deleteChat
    await _firestore.collection('chatRooms').doc(chatRoomId).delete();
  }
}