part of 'main_home_screen.dart';

class _CustomBottomSheet extends StatelessWidget {
  const _CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Neumorphic(
        style: CustomNeumorphicStyle.neumorphicD3.copyWith(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAnimatedButton(
                    animatedIcon: AnimatedIcons.view_list,
                    onTap: () {},
                  ),
                  CustomAnimatedButton(
                    animatedIcon: AnimatedIcons.close_menu,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
