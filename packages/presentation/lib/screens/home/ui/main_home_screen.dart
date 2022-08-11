// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/core/helpers/debugging.dart';
import 'package:domain/core/typedefs/login_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/pages/calls_page/calls_page.dart';
import 'package:presentation/pages/contact_page/contacts_page.dart';
import 'package:presentation/pages/message/main_messages_page.dart';
import 'package:presentation/pages/notification/notifications_page.dart';
import 'package:presentation/screens/auth/app_bloc.dart';
import 'package:presentation/widgets/animated_icon.dart';
import 'package:presentation/widgets/avatar.dart';
import 'package:presentation/widgets/icon_avatar.dart';

part 'greate_user/bottom_sheet.dart';
part 'nav_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final AppBloc bloc;

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
      const MessagesPage(),
      const UploadingImage(),
      CallsPage(),
      const ContactsPage(),
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
            onPressed: () => showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => _CustomBottomSheet(
                    createContact: bloc.createContact,
                    goBack: bloc.goToContactListView)),
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
