import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/cubit/message/message_cubit.dart';
import 'package:health_tourism/cubit/message/message_state.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
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
        print(FirebaseAuth.instance.currentUser!.uid);
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageBubble(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  Widget _buildMessageBubble(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    var alignment = data['senderId'] == FirebaseAuth.instance.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var color = data['senderId'] == FirebaseAuth.instance.currentUser!.uid
        ? const Color(0xff373e4e)
        : const Color(0xff7a8194);
    String message = data['message'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: alignment,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: HTText(
            label: message,
            color: Colors.white,
            style: htLabelStyle,
          ),
        ),
      ),
    );
  }
}
