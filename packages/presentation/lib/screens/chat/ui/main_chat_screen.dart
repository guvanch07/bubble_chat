import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/heplers/date_formater.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/screens/chat/cubit/chat_messages_cubit.dart';
import 'package:presentation/widgets/avatar.dart';
import 'package:presentation/widgets/icon_avatar.dart';
import 'package:presentation/widgets/text_field.dart';
import 'package:domain/entities/my_chat_entity.dart';
import 'package:domain/entities/text_messsage_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'action_button.dart';
part 'app_bar_title.dart';
part 'date_label.dart';
part 'message_list.dart';

class ChatScreen extends StatelessWidget {
  static Route route(
          {MyChatEntity? messageData,
          String? uid,
          String? otherUid,
          required bool chatType}) =>
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          chatType: chatType,
          messageData: messageData,
          uid: uid,
          otherUid: otherUid,
        ),
      );

  const ChatScreen({
    Key? key,
    required this.messageData,
    required this.chatType,
    this.uid,
    this.otherUid,
  }) : super(key: key);

  final MyChatEntity? messageData;
  final String? uid;
  final String? otherUid;
  final bool chatType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 54,
          leading: Container(
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.all(3),
            child: IconAvatar(
                margin: 0,
                icon: const Icon(CupertinoIcons.back, size: 20),
                iconColor: AppColors.accent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                radius: 30),
          ),
          title: _AppBarTitle(messageData: messageData),
          actions: _actions),
      body: Column(
        children: [
          _DemoMessageList(messageData: messageData, chatType: chatType),
          _ActionBar(
            myChatEntity: messageData,
            otherUid: otherUid,
            uid: uid,
          ),
        ],
      ),
    );
  }
}

final List<Widget> _actions = [
  IconAvatar(
      margin: 0,
      icon: const Icon(
        CupertinoIcons.video_camera_solid,
        size: 20,
      ),
      iconColor: AppColors.accent,
      onPressed: () {},
      radius: 35),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: IconAvatar(
        margin: 0,
        icon: const Icon(
          CupertinoIcons.phone_fill,
          size: 20,
        ),
        iconColor: AppColors.accent,
        onPressed: () {},
        radius: 35),
  ),
];
