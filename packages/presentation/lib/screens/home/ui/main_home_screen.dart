import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/pages/calls_page/calls_page.dart';
import 'package:presentation/pages/contact_page/contacts_page.dart';
import 'package:presentation/pages/message/main_messages_page.dart';
import 'package:presentation/pages/notification/notifications_page.dart';
import 'package:presentation/widgets/avatar.dart';
import 'package:presentation/widgets/icon_avatar.dart';

part 'nav_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  final String uid;
  HomeScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

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
    final pages = [
      MessagesPage(uid: uid),
      const UploadingImage(),
      const CallsPage(),
      ContactsPage(uid: uid),
    ];
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
              onPressed: () {}),
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
