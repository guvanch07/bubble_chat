// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "main_chat_screen.dart";

class _ActionBar extends StatelessWidget {
  const _ActionBar({
    Key? key,
    required this.uid,
    required this.otherUid,
  }) : super(key: key);
  final String? uid;
  final String? otherUid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: _ActionSection(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              color: AppColors.accent,
              icon: const Icon(CupertinoIcons.mic_fill, size: 25),
              onPressed: () {
              context.read<ChatMessagesCubit>().sendTextMessage(channel: true,textMessageEntity: TextMessageEntity(),channelId: );
                // BlocProvider.of<UserCubit>(context)
                //     .createOneToOneChatChannel(
                //         user: EngageUserEntity(
                //       uid: uid,
                //       otherUid: otherUid,
                //     ))
                //     .whenComplete(() => BlocProvider.of<UserCubit>(context)
                //             .addToMyChat(MyChatEntity(
                //           senderUID: uid,
                //           recipientUID: otherUid,
                //           senderName: "fdf",
                //           recipientName: 'sdsd',
                //         )));

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFields(
      prefix: IconButton(
        icon: const Icon(
          Icons.emoji_emotions_outlined,
          size: 20,
          color: AppColors.accent,
        ),
        onPressed: () {},
      ),
      suffix: SizedBox(
        width: MediaQuery.of(context).size.width * 0.18,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          InkWell(
            splashColor: AppColors.accent,
            onTap: () {},
            child: const Icon(CupertinoIcons.folder,
                size: 18, color: AppColors.accent),
          ),
          const Spacer(),
          InkWell(
            splashColor: AppColors.accent,
            onTap: () {},
            child: const Icon(CupertinoIcons.camera_fill,
                size: 18, color: AppColors.accent),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
