import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/chat_bubble.dart';
import 'package:health_tourism/cubit/message/message_cubit.dart';
import 'package:health_tourism/cubit/message/message_state.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/vertical_space.dart';
import '../../product/theme/styles.dart';

class ChatRoomView extends StatefulWidget {
  String receiverId;
  String receiverName;
  String chatRoomId;

  ChatRoomView({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.chatRoomId,
  });

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b202d),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  HTIcon(
                      onPress: () {
                        context.pop();
                      },
                      iconName: AssetConstants.icons.backIcon,
                      color: Colors.white,
                      width: 24,
                      height: 24),
                  // image gelecek bu araya
                  const HorizontalSpace(spaceAmount: 16),
                  HTText.title(
                    context: context,
                    label: widget.receiverId,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<MessageCubit, MessageState>(
                builder: (context, state) {
                  if (state is MessageLoaded) {
                    return _buildMessageListView(state);
                  }
                  if (state is MessageError) {
                    return Center(
                      child: HTText(
                        label: state.message,
                        color: Colors.white,
                        style: htLabelStyle,
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            _buildMessageInputField(widget.receiverId),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageListView(MessageLoaded state) {
    return StreamBuilder(
      stream: state.messages,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: HTText(
              label: "Something went wrong",
              color: Colors.white,
              style: htLabelStyle,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageBubble(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageBubble(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    var alignment = data['senderId'] == FirebaseAuth.instance.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;

    String message = data['message'];

    var boxDecoration =
        data['senderId'] == FirebaseAuth.instance.currentUser!.uid
            ? const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Color(0xff373e4e),
              )
            : const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: Color(0xff7a8194),
              );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 6),
      child: Container(
        color: Colors.transparent,
        alignment: alignment,
        child: Column(
          crossAxisAlignment: alignment == Alignment.centerLeft
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            const HTText(label: "label", style: htSmallLabelStyle),
            const VerticalSpace(spaceAmount: 4),
            ChatBubble(
              message: message,
              boxDecoration: boxDecoration,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInputField(String receiverId) {
    final messageController = TextEditingController();

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
              ),
            ),
            const HorizontalSpace(spaceAmount: 8),
            Expanded(
              child: TextField(
                controller: messageController,
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
                        receiverId: receiverId,
                        message: messageController.text,
                      );
                  messageController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
