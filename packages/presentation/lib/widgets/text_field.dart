// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/theme/theme.dart';

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key? key,
    this.prefix,
    this.suffix,
    required this.controller,
  }) : super(key: key);
  final Widget? prefix;
  final Widget? suffix;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        shadowDarkColor: Colors.black,
        shadowLightColorEmboss: AppColors.cardLight,
        shadowLightColor: AppColors.cardLight,
        shadowDarkColorEmboss: Colors.black,
        color: AppColors.cardDark,
        depth: -2,
        boxShape: NeumorphicBoxShape.stadium(),
      ),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.accent,
        style: const TextStyle(fontSize: 14),
        maxLines: null,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          hintText: 'Type something...',
          focusColor: Colors.black,
          focusedErrorBorder:
              const OutlineInputBorder(borderSide: BorderSide()),
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(5),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide()),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide()),
          border: const OutlineInputBorder(borderSide: BorderSide()),
          errorBorder: const OutlineInputBorder(borderSide: BorderSide()),
          hintStyle: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
