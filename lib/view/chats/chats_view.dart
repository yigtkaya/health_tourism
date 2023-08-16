import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/cubit/chat_cubit/chat_cubit.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/theme/styles.dart';
import '../../core/constants/vertical_space.dart';
import '../../cubit/chat_cubit/chat_state.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff2D9CDB),
            ),
            height: size.height * 0.07,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HTIcon(
                    iconName: AssetConstants.icons.burger,
                    onPress: () => context.pop(),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: HTText(label: "Reviews", style: htToolBarLabel),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalSpace(),
          Expanded(
            flex: 3,
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoaded) {
                  return _buildChatListView(state);
                }
                if (state is ChatError) {
                  return Center(
                    child: HTText(
                      label: "Something went wrong",
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
        ],
      )),
    );
  }

  Widget _buildChatListView(ChatLoaded state) {
    return StreamBuilder(
      stream: state.chats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String currentUserId = FirebaseAuth.instance.currentUser!.uid;
              String lastMessage = data['lastMessage']['message'];
              List id = data['ids'];
              String chatRoomId = id.join("_");
              id.remove(currentUserId);
              String receiverId = id[0];

              if (data['lastMessage']['senderId'] != currentUserId) {
                lastMessage =
                    "${data['lastMessage']['senderId']}: $lastMessage";
              } else {
                lastMessage = "You: $lastMessage";
              }
              DateTime t = data['lastMessage']['lastMessageTime'].toDate();
              // check if the message is sent today or yesterday or before
              String formattedDate = context.read<ChatCubit>().formatDate(t);
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.pushNamed(RoutePath.chatRoom, queryParameters: {
                      "receiverId": receiverId,
                      "chatRoomId": chatRoomId,
                      "receiverName": receiverId,
                    });
                  },
                  child: _buildLineItem(
                      lastMessage, receiverId, chatRoomId, formattedDate));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildLineItem(String lastMessage, String receiverId,
      String chatRoomId, String formattedDate) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 10),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://image.shutterstock.com/image-photo/hospital-interior-operating-surgery-table-260nw-1407429638.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const HorizontalSpace(
                spaceAmount: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HTText(
                    label: receiverId,
                    style: htSubTitle,
                  ),
                  const VerticalSpace(
                    spaceAmount: 6,
                  ),
                  HTText(
                    label: lastMessage,
                    style: htBlueLabelStyle,
                  ),
                ],
              ),
              const Spacer(),
              HTText(
                label: formattedDate,
                style: htSmallLabelStyle,
              ),
            ],
          ),
        ),
        const Divider(
          color: Color(0xffd3e3f1),
          thickness: 1,
        ),
      ],
    );
  }
}
