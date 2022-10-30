// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/models/message_data.dart';
import 'package:domain/models/story_data.dart';
import 'package:faker/faker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jiffy/jiffy.dart';
import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/pages/message/cubit/messages_cubit.dart';
import 'package:presentation/screens/chat/ui/main_chat_screen.dart';
import 'package:presentation/screens/story/cubit/image_handler_cubit.dart';
import 'package:presentation/screens/story/main_story.dart';
import 'package:presentation/widgets/avatar.dart';
import 'package:presentation/widgets/icon_avatar.dart';
import 'package:domain/entities/my_chat_entity.dart';

part 'message_tile.dart';
part 'stories_widget.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    context.read<MessagesCubit>().getUsers(widget.uid);
    log('called');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _Stories(),
        BlocBuilder<MessagesCubit, MessagesState>(
          builder: (context, state) {
            if (state is MessagesLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is MessagesLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final messagesData = state.myChats[index];
                  return _MessageTile(messageData: messagesData);
                },
                itemCount: state.myChats.length,
              );
            }

            return const SizedBox();
          },
        )
      ],
    );
  }

  // Widget _delegate(BuildContext context, int index) {
  //   final Faker faker = Faker();
  //   final date = Helpers.randomDate();
  //   return BlocBuilder<MessagesCubit, MessagesState>(
  //     builder: (context, state) {
  //       if (state is MessagesLoading) {
  //         return const Center(child: CircularProgressIndicator.adaptive());
  //       }
  //       if (state is MessagesLoaded) {
  //         return _MessageTile(
  //           messageData: MessageData(
  //             senderName: state.myChats[index].senderName ?? '',
  //             message: state.myChats[index].recentTextMessage ?? '',
  //             messageDate:
  //                 state.myChats[index].time?.toDate() ?? DateTime.now(),
  //             dateMessage: Jiffy(date).fromNow(),
  //             profilePicture: Helpers.randomPictureUrl(),
  //           ),
  //         );
  //       }

  //       return const SizedBox();
  //     },
  //   );
  // }
}
