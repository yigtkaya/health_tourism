import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp messageTime;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messageTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': messageTime,
    };
  }

 Map<String, dynamic> fromMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': messageTime,
    };
  }
}