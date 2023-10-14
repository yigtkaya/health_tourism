import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/product/repoImpl/message_repo_impl.dart';
import 'package:health_tourism/product/repoImpl/notification_repo_impl.dart';
import '../../core/constants/horizontal_space.dart';
import '../../cubit/message/message_cubit.dart';
import '../../product/models/clinic.dart';

class SendImageView extends StatefulWidget {
  String imagePath;
  String receiverId;
  String senderName;
  String receiverName;

  SendImageView(
      {super.key,
      required this.imagePath,
      required this.receiverId,
      required this.senderName,
      required this.receiverName});

  @override
  State<SendImageView> createState() => _SendImageViewState();
}

class _SendImageViewState extends State<SendImageView> {
  final TextEditingController _messageController = TextEditingController();
  final repo = MessageRepositoryImpl();
  late File imageFile;
  late String chatRoomId;
  late Clinic clinic;
  bool singleTap = true;

  @override
  void initState() {
    imageFile = File(widget.imagePath);
    chatRoomId =
        [FirebaseAuth.instance.currentUser!.uid, widget.receiverId].join("_");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HTIcon(
                  iconName: AssetConstants.icons.chevronLeft,
                  onPress: () {
                    context.pop();
                  },
                  height: 28,
                  width: 28,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(imageFile),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xff9398a7),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const HorizontalSpace(spaceAmount: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: HTIcon(
                    iconName: AssetConstants.icons.sendIcon,
                    width: 32,
                    height: 32,
                    color: Colors.black,
                    onPress: () async {
                      if (singleTap) {
                          String imageUrl =
                          await repo.uploadImageToFirebase(imageFile, chatRoomId);
                          if (mounted) {
                            BlocProvider.of<MessageCubit>(context).sendMessage(
                                widget.receiverId,
                                _messageController.text,
                                imageUrl,
                                widget.senderName,
                                widget.receiverName);


                            NotificationRepoImpl().sendPushNotificationToClinic(
                                widget.senderName,
                                _messageController.text,
                                widget.receiverId);
                          }
                      }
                      setState(() {
                        singleTap = false; // update bool
                      });
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalSpace(),
        ],
      )),
    );
  }
}
