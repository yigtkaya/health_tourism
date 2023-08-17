import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/chat/chat_bubble.dart';
import 'package:health_tourism/core/components/chat/chat_input.dart';
import 'package:health_tourism/cubit/message/message_cubit.dart';
import 'package:health_tourism/cubit/message/message_state.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';
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
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: const Color(0xff2D9CDB),
        elevation: 0,
        centerTitle: true,
        leadingWidth: 42,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: HTIcon(iconName: AssetConstants.icons.chevronLeft, onPress: () {
            context.pop();
          },),
        ),
        title: HTText(
          label: widget.receiverName,
          style: htToolBarLabel,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
                        style: htDarkBlueNormalStyle,
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            ChatInputField(receiverId: widget.receiverId),
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
          return Center(
            child: HTText(
              label: "Something went wrong",
              color: Colors.white,
              style: htDarkBlueNormalStyle,
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

    var messageColor =
        data['senderId'] == FirebaseAuth.instance.currentUser!.uid
            ? ThemeManager.instance?.getCurrentTheme.colorTheme.openBlueTextColor
            : Colors.white;

    var boxDecoration =
        data['senderId'] == FirebaseAuth.instance.currentUser!.uid
            ? const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Color(0xfff6f8fb),
              )
            : const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: Color(0xff1587f8),
              );

    String imageUrl = data['imageUrl'];
    String message = data['message'];
    DateTime t = data['messageTime'].toDate();
    String formattedTime = '${t.hour}:${t.minute}';
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
            HTText(label: data['senderId'], style: htSmallLabelStyle),
            const VerticalSpace(spaceAmount: 4),
            ChatBubble(
              message: message,
              boxDecoration: boxDecoration,
              imageUrl: imageUrl,
              time: formattedTime,
              messageColor: messageColor,
            ),
          ],
        ),
      ),
    );
  }
}
