import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_text.dart';

import '../../product/theme/styles.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final BoxDecoration boxDecoration;

  const ChatBubble({super.key, required this.message, required this.boxDecoration,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: boxDecoration,
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
