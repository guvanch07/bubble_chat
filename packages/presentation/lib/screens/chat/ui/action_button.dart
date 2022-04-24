part of "main_chat_screen.dart";

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);

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
            child: IconAvatar(
                color: AppColors.accent,
                icon: const Icon(CupertinoIcons.mic_fill, size: 25),
                iconColor: AppColors.textLigth,
                onPressed: () {},
                radius: 60),
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
