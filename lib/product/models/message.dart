
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_tourism/product/models/message_type.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final MessageType type;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'type': type.index,
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : senderId = map['senderId'],
        receiverId = map['receiverId'],
        message = map['message'],
        timestamp = map['timestamp'],
        type = MessageType.values[map['type']];

  
}