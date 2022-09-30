// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_chat_screen.dart';

class _DemoMessageList extends StatefulWidget {
  const _DemoMessageList({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MyChatEntity? messageData;

  @override
  State<_DemoMessageList> createState() => _DemoMessageListState();
}

class _DemoMessageListState extends State<_DemoMessageList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.messageData == null) {
      'empty';
    }
    context.read<ChatMessagesCubit>().getMessages(
        channel: true, channelId: widget.messageData?.channelId ?? '');
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
                messageData: widget.messageData,
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
    this.messageData,
    required this.scrollController,
  }) : super(key: key);

  final List<TextMessageEntity> messages;
  final MyChatEntity? messageData;
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
        if (msg.senderId != messageData?.senderUID) {
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
