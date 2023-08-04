import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/cubit/chat_cubit/chat_cubit.dart';
import 'package:health_tourism/product/theme/styles.dart';

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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff292f3f),
              ),
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ChatLoaded) {
                    return StreamBuilder(
                            stream: state.chats,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Error"),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                                return ListView(
                                  children: snapshot.data!.docs
                                      .map((document) => _buildLineItem(document))
                                      .toList(),
                                );
                            },
                          );
                  } else {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildLineItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: const DecorationImage(
              image: NetworkImage("https://image.shutterstock.com/image-photo/hospital-interior-operating-surgery-table-260nw-1407429638.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HTText(
                label: data.values.toList()[0],
                color: Colors.white,
                style: htLabelStyle,
              ),
              HTText(
                label: data['lastMessage']['message'],
                color: Colors.white,
                style: htLabelStyle,
              ),
            ],
          ),
        ),
        HTText(
          label: data['lastMessage']['lastMessageTime'],
          color: Colors.white,
          style: htLabelStyle,
        ),
      ],
    );
  }
}
