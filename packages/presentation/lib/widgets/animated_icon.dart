import 'package:flutter/material.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/widgets/icon_avatar.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({
    Key? key,
    required this.animatedIcon,
    required this.onTap,
  }) : super(key: key);

  final AnimatedIconData animatedIcon;
  final VoidCallback onTap;

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool isClicked = false;

  void animateWidget() {
    setState(() {
      if (isClicked) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconAvatar(
        radius: 40,
        color: AppColors.accent,
        icon: const Text(""),
        iconColor: Colors.white,
        onPressed: () {},
        child: InkWell(
          onTap: () {
            animateWidget();
            widget.onTap();
          },
          child: AnimatedIcon(
            color: Colors.white,
            icon: widget.animatedIcon,
            progress: _controller,
          ),
        ));
  }
}
