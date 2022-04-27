import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/core/theme/neumorphic.dart';
import 'package:presentation/core/theme/theme.dart';

import 'package:presentation/pages/message/main_messages_page.dart';
import 'package:presentation/pages/music_page/music_page.dart';

import 'package:presentation/pages/photo_page/photo_page.dart';
import 'package:presentation/pages/settings_page/settings_page.dart';
import 'package:presentation/widgets/animation/animated_icon.dart';
import 'package:presentation/widgets/avatar.dart';
import 'package:presentation/widgets/icon_avatar.dart';

part 'nav_bar_widget.dart';
part 'bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = [
    const MessagesPage(),
    const PhotoPage(),
    MusicPage(),
    const SettingsPage(),
  ];

  final pageTitles = const [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts',
  ];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: Avatar(url: Helpers.randomPictureUrl(), radius: 40),
        ),
        actions: [
          IconAvatar(
            radius: 40,
            color: AppColors.accent,
            icon: const Icon(CupertinoIcons.add, size: 18),
            iconColor: Colors.white,
            onPressed: () => showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => const _CustomBottomSheet()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconAvatar(
              radius: 40,
              color: AppColors.accent,
              icon: const Icon(CupertinoIcons.search, size: 18),
              iconColor: Colors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}
