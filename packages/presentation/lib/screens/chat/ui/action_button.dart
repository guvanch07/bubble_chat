part of "main_chat_screen.dart";

class _ActionBar extends HookWidget {
  const _ActionBar({
    Key? key,
    required this.uid,
    required this.otherUid,
    required this.myChatEntity,
  }) : super(key: key);
  final String? uid;
  final String? otherUid;
  final MyChatEntity myChatEntity;

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
                if (MyChatEntity().recipientUID == null) {
                  BlocProvider.of<UserCubit>(context).addToMyChat(MyChatEntity(
                    senderUID: uid,
                    recipientUID: otherUid,
                    senderName: myChatEntity.senderName,
                    recipientName: myChatEntity.recipientName,
                  ));
                }

                if (msgController.text.isNotEmpty) {
                  context.read<ChatMessagesCubit>().sendTextMessage(
                      channel: true,
                      textMessageEntity: TextMessageEntity(
                          senderId: myChatEntity.senderUID,
                          senderName: myChatEntity.senderName,
                          receiverName: myChatEntity.recipientName,
                          recipientId: myChatEntity.recipientUID,
                          content: msgController.text),
                      channelId: myChatEntity.channelId ?? '');
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
