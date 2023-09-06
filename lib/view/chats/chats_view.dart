import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/cubit/chat_cubit/chat_cubit.dart';
import 'package:health_tourism/product/models/user.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/theme/styles.dart';
import '../../core/constants/vertical_space.dart';
import '../../cubit/chat_cubit/chat_state.dart';
import '../../product/theme/theme_manager.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2D9CDB),
        elevation: 0,
        leadingWidth: 32,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: HTIcon(
            iconName: AssetConstants.icons.burger,
            onPress: () => context.pop(),
          ),
        ),
        centerTitle: true,
        title: HTText(
          label: "Inbox",
          style: htToolBarLabel,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const VerticalSpace(),
            Expanded(
              flex: 4,
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
        ),
      ),
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
              List messages = data["messages"];
              String currentUserId = FirebaseAuth.instance.currentUser!.uid;
              Map<String, dynamic> lastMessage = messages.lastOrNull;

              List id = data['ids'];
              String chatRoomId = id.join("_");
              id.remove(currentUserId);
              String receiverId = id[0];

              List names = data["names"];
              String receiverName = names.first;
              String senderName = names.last;
              Widget lastMessageWidget = const SizedBox.shrink();

              if (lastMessage["senderId"] == currentUserId) {
                lastMessageWidget = HTText(
                    label: "You: ${lastMessage["message"]}",
                    style: htBlueLabelStyle);
                if (lastMessage["imageUrl"] != "") {
                  lastMessageWidget =
                      Row(
                        children: [
                          HTText(label: "${lastMessage["senderName"]}: ", style: htBlueLabelStyle),
                          HTIcon(iconName: AssetConstants.icons.image, height: 24, width: 24, color:ThemeManager.instance?.getCurrentTheme.colorTheme.openBlueTextColor,),
                        ],
                      );
                }
              } else {
                lastMessageWidget = HTText(
                    label:
                    "${lastMessage["senderName"]}: ${lastMessage["message"]}",
                    style: htBlueLabelStyle);
                if (lastMessage["imageUrl"] != "") {
                  lastMessageWidget =
                      Row(
                        children: [
                          HTText(label: "${lastMessage["senderName"]}: ", style: htBlueLabelStyle),
                          HTIcon(iconName: AssetConstants.icons.image, height: 24, width: 24, color:ThemeManager.instance?.getCurrentTheme.colorTheme.openBlueTextColor,),
                        ],
                      );
                }
              }

              DateTime t = lastMessage['messageTime'].toDate();
              // check if the message is sent today or yesterday or before
              String formattedDate = context.read<ChatCubit>().formatDate(t);
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.pushNamed(RoutePath.chatRoom, queryParameters: {
                      "receiverId": receiverId,
                      "chatRoomId": chatRoomId,
                      "receiverName": receiverName,
                      "senderName": senderName
                    });
                  },
                  child: Slidable(
                    endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 1 / 6,
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: (context) {
                              context.read<ChatCubit>().deleteChat(chatRoomId);
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete_sharp,
                          ),
                        ]),
                    child: _buildLineItem(lastMessageWidget, receiverName,
                        chatRoomId, formattedDate),
                  ));
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

  Widget _buildLineItem(Widget lastMessageWidget, String receiverName,
      String chatRoomId, String formattedDate) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
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
                    label: receiverName,
                    style: htSubTitle,
                  ),
                  const VerticalSpace(
                    spaceAmount: 6,
                  ),
                  lastMessageWidget
                ],
              ),
              const Spacer(),
              HTText(
                label: formattedDate,
                style: htSmallLabelStyle,
              ),
            ],
          ),
          const Divider(
            color: Color(0xffd3e3f1),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
