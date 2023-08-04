import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/cubit/chat_cubit/chat_cubit.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/navigation/router.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xff1b202d),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                HTText.title(
                  context: context,
                  label: "Messages",
                  color: Colors.white,
                ),
                const Spacer(),
                HTIcon(
                  iconName: AssetConstants.icons.infoIcon,
                  color: Colors.white,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: const HTText(
                label: "Chats",
                color: Colors.white,
                style: htLabelStyle,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Color(0xff292f3f),
              ),
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoaded) {
                    return _buildChatListView(state);
                  }
                  if (state is ChatError) {
                    return const Center(
                      child: HTText(
                        label: "Something went wrong",
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
              return GestureDetector(onTap: () {
                goTo(path: RoutePath.chatRoom);
              },child: _buildLineItem(snapshot.data!.docs[index]));
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

  Widget _buildLineItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String lastMessage = data['lastMessage']['message'];
    // find id that matches with current user id from data ids
    List id = data['ids'];
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    id.remove(currentUserId);
    String receiverId = id[0];
    // convert time stamp to date
    DateTime t = data['lastMessage']['lastMessageTime'].toDate();
    // check if the message is sent today or yesterday or before
    String formattedDate = context.read<ChatCubit>().formatDate(t);


    if (data['lastMessage']['senderId'] != currentUserId) {
      lastMessage = "${data['lastMessage']['senderId']}: $lastMessage";
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 10),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
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
                    color: Colors.white,
                    style: htLabelStyle,
                  ),
                  const VerticalSpace(
                    spaceAmount: 6,
                  ),
                  HTText(
                    label: lastMessage,
                    color: Colors.white,
                    style: htLabelStyle,
                  ),
                ],
              ),
              const Spacer(),
              HTText(
                label: formattedDate,
                color: Colors.white,
                style: htSmallLabelStyle,
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
      ],
    );
  }
}
