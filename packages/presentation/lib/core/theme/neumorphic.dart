import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/theme/theme.dart';

abstract class CustomNeumorphicStyle {
  static const NeumorphicStyle neumorphicD3 = NeumorphicStyle(
    shadowDarkColor: Colors.black,
    shadowLightColorEmboss: AppColors.cardLight,
    shadowLightColor: AppColors.cardLight,
    shadowDarkColorEmboss: Colors.black,
    color: AppColors.cardDark,
    depth: 3,
    boxShape: NeumorphicBoxShape.circle(),
  );
}
