part of 'main_chat_screen.dart';

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: const [
            _DateLable(lable: 'Yesterday'),
            _MessageTile(
              message: 'Hi, Lucy! How\'s your day going?',
              messageDate: '12:01 PM',
            ),
            _MessageOwnTile(
              message: 'You know how it goes...',
              messageDate: '12:02 PM',
            ),
            _MessageTile(
              message: 'Do you want Starbucks?',
              messageDate: '12:02 PM',
            ),
            _MessageOwnTile(
              message: 'Would be awesome!',
              messageDate: '12:03 PM',
            ),
            _MessageTile(
              message: 'Coming up!',
              messageDate: '12:03 PM',
            ),
            _MessageOwnTile(
              message: 'YAY!!!',
              messageDate: '12:03 PM',
            ),
          ],
        ),
      ),
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
