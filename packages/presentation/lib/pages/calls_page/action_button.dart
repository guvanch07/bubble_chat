import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/screens/chat/cubit/chat_messages_cubit.dart';
import 'package:domain/entities/group_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presentation/widgets/text_field.dart';
import 'package:domain/entities/text_messsage_entity.dart';

class GroupActionBar extends HookWidget {
  const GroupActionBar({
    Key? key,
    required this.groupEntity,
    required this.uid,
  }) : super(key: key);

  final GroupEntity groupEntity;
  final String uid;

  @override
  Widget build(BuildContext context) {
    final msgController = useTextEditingController();
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: _ActionSection(controller: msgController),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              color: AppColors.accent,
              icon: const Icon(Icons.send, size: 25),
              onPressed: () {
                if (msgController.text.isNotEmpty) {
                  context.read<ChatMessagesCubit>().sendTextMessage(
                      channel: false,
                      textMessageEntity: TextMessageEntity(
                          senderId: uid,
                          time: Timestamp.now(),
                          content: msgController.text),
                      channelId: groupEntity.groupId);
                  msgController.clear();
                }

                log('pressed');
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFields(
      controller: controller,
      prefix: IconButton(
        icon: const Icon(
          Icons.emoji_emotions_outlined,
          size: 20,
          color: AppColors.accent,
        ),
        onPressed: () {},
      ),
      suffix: IconButton(
        onPressed: () {},
        icon: const Icon(CupertinoIcons.folder,
            size: 18, color: AppColors.accent),
      ),
    );
  }
}
