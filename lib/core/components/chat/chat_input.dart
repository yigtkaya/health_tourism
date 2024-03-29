import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/dialog/chat_image_dialog.dart';
import 'package:health_tourism/product/models/message.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';
import '../../../cubit/message/message_cubit.dart';
import '../../../product/models/clinic.dart';
import '../../../product/repoImpl/clinic_repo_impl.dart';
import '../../../product/repoImpl/notification_repo_impl.dart';
import '../../../product/theme/styles.dart';
import '../../constants/asset.dart';
import '../../constants/horizontal_space.dart';
import '../ht_icon.dart';

class ChatInputField extends StatefulWidget {
  final Clinic clinic;
  final String senderName;
  final String receiverName;
  final String receiverId;
  final File? imageFile;

  const ChatInputField(
      {super.key,
      required this.clinic,
      required this.senderName,
      required this.receiverId,
      this.imageFile,
      required this.receiverName});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFD3E3F1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              HTIcon(
                iconName: AssetConstants.icons.cameraIcon,
                width: 26,
                height: 26,
                color: ThemeManager
                    .instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
                onPress: () {
                  // show image picker dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ChatImagePickerDialog(
                        receiverId: widget.receiverId,
                        senderName: widget.senderName,
                        receiverName: widget.receiverName,
                      );
                    },
                  );
                },
              ),
              const HorizontalSpace(
                spaceAmount: 16,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3E3F1).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: _messageController,
                      style: htDarkBlueNormalStyle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Message",
                        hintStyle: htHintTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: HTIcon(
                  iconName: AssetConstants.icons.sendIcon,
                  width: 26,
                  height: 26,
                  color: ThemeManager
                      .instance?.getCurrentTheme.colorTheme.darkBlueTextColor,
                  onPress: () {
                    context.read<MessageCubit>().sendMessage(
                        widget.receiverId,
                        _messageController.text,
                        "",
                        widget.senderName,
                        widget.receiverName);

                    NotificationRepoImpl()
                        .sendPushNotificationToClinic(
                        widget.senderName,
                        _messageController.text,
                        widget.clinic,
                    );

                    _messageController.clear();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
