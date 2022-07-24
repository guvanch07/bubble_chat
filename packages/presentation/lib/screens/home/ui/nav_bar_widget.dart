part of "main_home_screen.dart";

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  __BottomNavigationBarState createState() => __BottomNavigationBarState();
}

class __BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
      child: Neumorphic(
        style: const NeumorphicStyle(
          shadowDarkColor: Colors.black,
          shadowLightColorEmboss: AppColors.cardLight,
          shadowLightColor: AppColors.cardLight,
          shadowDarkColorEmboss: Colors.black,
          //shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.stadium(),
          color: AppColors.cardDark,
          depth: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigationBarItem(
              index: 0,
              lable: 'Messages',
              icon: CupertinoIcons.bubble_left_fill,
              isSelected: (selectedIndex == 0),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 1,
              lable: 'Notifications',
              icon: CupertinoIcons.camera,
              isSelected: (selectedIndex == 1),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 2,
              lable: 'Calls',
              icon: CupertinoIcons.music_albums,
              isSelected: (selectedIndex == 2),
              onTap: handleItemSelected,
            ),
            _NavigationBarItem(
              index: 3,
              lable: 'Contacts',
              icon: CupertinoIcons.settings,
              isSelected: (selectedIndex == 3),
              onTap: handleItemSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index,
    required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: Neumorphic(
        style: NeumorphicStyle(
            shadowDarkColor: Colors.black,
            shadowLightColorEmboss: AppColors.cardLight,
            shadowLightColor: AppColors.cardLight,
            shadowDarkColorEmboss: Colors.black,
            color: AppColors.cardDark,
            depth: isSelected ? -2 : 3,
            boxShape: const NeumorphicBoxShape.circle()),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Icon(
            icon,
            size: 22,
            color: isSelected ? AppColors.accent : null,
          ),
        ),
      ),
    );
  }
}
