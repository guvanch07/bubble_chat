import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/theme/theme.dart';

class IconAvatar extends StatelessWidget {
  final double radius;
  final VoidCallback onPressed;
  final Widget icon;
  final Color? color;
  final Widget? child;
  final double? margin;
  final Color iconColor;

  const IconAvatar({
    Key? key,
    required this.radius,
    required this.onPressed,
    required this.icon,
    this.color,
    this.child,
    this.margin,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius,
      width: radius,
      child: Neumorphic(
        style: const NeumorphicStyle(
          shadowDarkColor: Colors.black,
          shadowLightColorEmboss: AppColors.cardLight,
          shadowLightColor: AppColors.cardLight,
          shadowDarkColorEmboss: Colors.black,
          color: AppColors.cardDark,
          depth: 3,
          boxShape: NeumorphicBoxShape.circle(),
        ),
        child: Container(
          margin: EdgeInsets.all(margin ?? 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: child ??
                IconButton(
                  color: iconColor,
                  icon: icon,
                  onPressed: onPressed,
                ),
          ),
        ),
      ),
    );
  }
}
