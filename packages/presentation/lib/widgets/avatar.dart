import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/theme/neumorphic.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final String url;
  final Color? color;
  final Widget? child;

  const Avatar({
    Key? key,
    required this.radius,
    required this.url,
    this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius,
      width: radius,
      child: Neumorphic(
        style: CustomNeumorphicStyle.neumorphicD3,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            image: DecorationImage(
              image: CachedNetworkImageProvider(url),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
