import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:domain/models/message_data.dart';
import 'package:presentation/widgets/avatar.dart';
import 'package:presentation/widgets/icon_avatar.dart';
import 'package:presentation/widgets/text_field.dart';

part 'action_button.dart';
part 'app_bar_title.dart';
part 'date_label.dart';
part 'message_list.dart';

class ChatScreen extends StatelessWidget {
  static Route route(MessageData data) => MaterialPageRoute(
        builder: (context) => ChatScreen(
          messageData: data,
        ),
      );

  const ChatScreen({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

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
        children: const [
          _DemoMessageList(),
          _ActionBar(),
        ],
      ),
    );
  }
}

final List<Widget>? _actions = [
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
