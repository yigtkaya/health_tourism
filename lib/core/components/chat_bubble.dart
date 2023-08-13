import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/theme/styles.dart';

import 'ht_text.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final BoxDecoration boxDecoration;
  final String imageUrl;
  final String time;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.boxDecoration,
      required this.imageUrl,
      required this.time});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool isImage = false;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrl != '') {
      setState(() {
        isImage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: widget.boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isImage
              ? GestureDetector(
                  onTap: () {
                    context
                        .pushNamed(RoutePath.fullscreenImage, queryParameters: {
                      "imageUrl": widget.imageUrl,
                    });
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: width - 150, maxHeight: height * 0.3),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 6),
            child: HTText(
              label: widget.message,
              color: Colors.white,
              style: htDarkBlueNormalStyle,
            ),
          ),
        ],
      ),
    );
  }
}
