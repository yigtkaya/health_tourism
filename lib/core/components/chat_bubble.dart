import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_tourism/product/theme/styles.dart';

import 'ht_text.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final BoxDecoration boxDecoration;

  const ChatBubble({
    super.key,
    required this.message,
    required this.boxDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: boxDecoration,
      child: HTText(
        label: message,
        color: Colors.white,
        style: htLabelStyle,
      ),
    );
  }
}
