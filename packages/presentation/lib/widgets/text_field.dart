import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/theme/neumorphic.dart';
import 'package:presentation/core/theme/theme.dart';

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    Key? key,
    this.prefix,
    this.suffix,
  }) : super(key: key);
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: CustomNeumorphicStyle.neumorphicD3
          .copyWith(depth: -3, boxShape: const NeumorphicBoxShape.stadium()),
      child: TextField(
        cursorColor: AppColors.accent,
        style: const TextStyle(fontSize: 14),
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
