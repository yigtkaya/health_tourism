
import 'package:health_tourism/product/models/message_type.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final MessageType type;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.type,
  });

  Message.toMap(Map<String, dynamic> map)
      : senderId = map['senderId'],
        receiverId = map['receiverId'],
        message = map['message'],
        timestamp = map['timestamp'],
        type = MessageType.values[map['type']];

  Message.fromMap(Map<String, dynamic> map)
      : senderId = map['senderId'],
        receiverId = map['receiverId'],
        message = map['message'],
        timestamp = map['timestamp'],
        type = MessageType.values[map['type']];

  
}