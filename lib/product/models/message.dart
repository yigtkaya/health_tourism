import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final String? imageUrl;
  final Timestamp messageTime;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.imageUrl,
    required this.messageTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'imageUrl': imageUrl,
      'messageTime': messageTime,
    };
  }

 Map<String, dynamic> fromMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'imageUrl': imageUrl,
      'messageTime': messageTime,
    };
  }
}