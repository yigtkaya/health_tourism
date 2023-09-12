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
import 'package:health_tourism/product/models/message.dart';
import 'package:health_tourism/product/theme/theme_manager.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../product/models/clinic.dart';
import '../../product/repoImpl/clinic_repo_impl.dart';
import '../../product/theme/styles.dart';

class ChatRoomView extends StatefulWidget {
  String receiverId;
  String receiverName;
  String chatRoomId;
  String senderName;

  ChatRoomView({
    super.key,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.chatRoomId,
  });

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  late ChatMessage chatMessage;
  late Clinic clinic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initClinic();
  }

  void initClinic() async {
    clinic = await ClinicRepositoryImpl().getClinic(widget.receiverId);
  }

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
          child: HTIcon(
            iconName: AssetConstants.icons.chevronLeft,
            onPress: () {
              context.pop();
            },
          ),
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
            ChatInputField(
              clinic: clinic,
              receiverId: widget.receiverId,
              receiverName: widget.receiverName,
              senderName: widget.senderName,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageListView(MessageLoaded state) {
    return StreamBuilder(
      stream: state.chatDocument,
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

        Map<String, dynamic> data =
            snapshot.data?.data() as Map<String, dynamic>;
        final messages = data["messages"];
        return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return _buildMessageBubble(messages[index]);
            });
      },
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> messageMap) {
    ChatMessage message = ChatMessage(
        senderId: messageMap["senderId"],
        receiverId: messageMap["receiverId"],
        message: messageMap["message"],
        messageTime: messageMap["messageTime"],
        imageUrl: messageMap["imageUrl"],
        senderName: messageMap["senderName"],
        receiverName: messageMap["receiverName"]);

    var alignment = message.senderId == FirebaseAuth.instance.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var messageColor = message.senderId ==
            FirebaseAuth.instance.currentUser!.uid
        ? ThemeManager.instance?.getCurrentTheme.colorTheme.openBlueTextColor
        : Colors.white;

    var boxDecoration =
        message.senderId == FirebaseAuth.instance.currentUser!.uid
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

    String? imageUrl = message.imageUrl;
    String text = message.message;
    DateTime t = message.messageTime.toDate();
    String formattedTime = '${t.hour}:${t.minute}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Container(
        color: Colors.transparent,
        alignment: alignment,
        child: Column(
          crossAxisAlignment: alignment == Alignment.centerLeft
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            ChatBubble(
              message: text,
              boxDecoration: boxDecoration,
              imageUrl: imageUrl ?? "",
              time: formattedTime,
              messageColor: messageColor,
            ),
          ],
        ),
      ),
    );
  }
}
