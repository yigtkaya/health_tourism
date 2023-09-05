import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderId;
  final String senderName;
  final String receiverName;
  final String receiverId;
  final String message;
  final String? imageUrl;
  final Timestamp messageTime;

  ChatMessage({
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.message,
    this.imageUrl,
    required this.messageTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'receiverName': receiverName,
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
      'receiverName': receiverName,
      'senderName': senderName,
      'message': message,
      'imageUrl': imageUrl,
      'messageTime': messageTime,
    };
  }
}