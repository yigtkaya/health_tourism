import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/navigation/router.dart';

import '../../cubit/message/message_cubit.dart';
import '../../product/theme/styles.dart';
import '../constants/asset.dart';
import '../constants/horizontal_space.dart';
import 'ht_icon.dart';

class ChatInputField extends StatefulWidget {
  final String receiverId;

  const ChatInputField({super.key, required this.receiverId});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Color(0xff3d4354),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xff9398a7),
                shape: BoxShape.circle,
              ),
              child: HTIcon(
                iconName: AssetConstants.icons.cameraIcon,
                width: 24,
                height: 24,
                onPress: () {
                  // show image picker dialog
                  pushTo(path: RoutePath.imagePickerDialog);

                },
              ),
            ),
            const HorizontalSpace(spaceAmount: 8),
            Expanded(
              child: TextField(
                controller: _messageController,
                style: htLabelStyle,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Message",
                  hintStyle: htHintTextStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: HTIcon(
                iconName: AssetConstants.icons.sendIcon,
                width: 24,
                height: 24,
                onPress: () {
                  context.read<MessageCubit>().sendMessage(
                    receiverId: widget.receiverId,
                    message: _messageController.text,
                  );
                  _messageController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
