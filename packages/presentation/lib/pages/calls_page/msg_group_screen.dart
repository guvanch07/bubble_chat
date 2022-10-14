// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:domain/entities/group_entity.dart';
import 'package:domain/entities/text_messsage_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/heplers/date_formater.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/pages/calls_page/action_button.dart';
import 'package:presentation/pages/calls_page/cubit/group_cubit.dart';
import 'package:presentation/screens/chat/cubit/chat_messages_cubit.dart';
import 'package:presentation/widgets/icon_avatar.dart';

class GroupChatScreen extends StatelessWidget {
  static Route route({required GroupEntity groupEntity, required String uid}) =>
      MaterialPageRoute(
        builder: (context) => GroupChatScreen(
          uid: uid,
          groupEntity: groupEntity,
        ),
      );

  const GroupChatScreen({
    Key? key,
    required this.groupEntity,
    required this.uid,
  }) : super(key: key);

  final GroupEntity groupEntity;
  final String uid;

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
      ),
      body: Column(
        children: [
          _DemoMessageList(groupEntity: groupEntity),
          GroupActionBar(groupEntity: groupEntity, uid: uid),
          //JoinButton(groupEntity: groupEntity)
        ],
      ),
    );
  }
}

class JoinButton extends StatelessWidget {
  const JoinButton({
    Key? key,
    required this.groupEntity,
  }) : super(key: key);
  final GroupEntity groupEntity;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        context.read<GroupCubit>().joinGroup(groupEntity: groupEntity);
      },
      color: AppColors.accent,
      child: const Text('join'),
    );
  }
}

class _DemoMessageList extends StatefulWidget {
  const _DemoMessageList({
    Key? key,
    required this.groupEntity,
  }) : super(key: key);

  final GroupEntity groupEntity;

  @override
  State<_DemoMessageList> createState() => _DemoMessageListState();
}

class _DemoMessageListState extends State<_DemoMessageList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context
        .read<ChatMessagesCubit>()
        .getMessages(channel: false, channelId: widget.groupEntity.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<ChatMessagesCubit, ChatMessagesState>(
          builder: (context, state) {
            if (state is ChatMessagesLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is ChatMessagesLoaded) {
              if (state.messages.isEmpty) {
                return const Text('empty');
              }
              return MsgReadSection(
                messages: state.messages,
                groupEntity: widget.groupEntity,
                scrollController: _scrollController,
              );
            }
            return const Text("something is wrong");
          },
        ),
      ),
    );
  }
}

class MsgReadSection extends StatelessWidget {
  const MsgReadSection({
    Key? key,
    required this.messages,
    required this.groupEntity,
    required this.scrollController,
  }) : super(key: key);

  final List<TextMessageEntity> messages;
  final GroupEntity groupEntity;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
    return ListView.separated(
      controller: scrollController,
      //reverse: true,
      itemBuilder: (context, index) {
        final msg = messages[index];
        if (msg.senderId != groupEntity.uid) {
          return _MessageTile(
            message: msg.content ?? '',
            messageDate: DateFormatter.timeformatter(msg.time?.toDate()),
          );
        }

        return _MessageOwnTile(
          message: msg.content ?? "",
          messageDate: DateFormatter.timeformatter(msg.time?.toDate()),
        );
      },
      itemCount: messages.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                shadowDarkColor: Colors.black,
                shadowLightColorEmboss: AppColors.cardLight,
                shadowLightColor: AppColors.cardLight,
                shadowDarkColorEmboss: Colors.black,
                color: AppColors.cardDark,
                depth: 3,
                boxShape: NeumorphicBoxShape.roundRect(
                  const BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    topRight: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Text(message),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                shadowDarkColor: Colors.black,
                shadowLightColorEmboss: AppColors.cardLight,
                shadowLightColor: AppColors.cardLight,
                shadowDarkColorEmboss: Colors.black,
                color: AppColors.accent,
                depth: 3,
                boxShape: NeumorphicBoxShape.roundRect(
                  const BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    topRight: Radius.circular(_borderRadius),
                    bottomLeft: Radius.circular(_borderRadius),
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Text(message,
                    style: const TextStyle(
                      color: AppColors.textLigth,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
