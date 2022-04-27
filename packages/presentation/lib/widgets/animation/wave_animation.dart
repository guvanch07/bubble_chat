import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/core/theme/neumorphic.dart';

import 'dart:math' as math show sin, pi;

import 'package:presentation/widgets/animation/animated_icon.dart';

class BreathAnimation extends StatefulWidget {
  const BreathAnimation({
    Key? key,
  }) : super(key: key);

  @override
  BreathAnimationState createState() => BreathAnimationState();
}

class BreathAnimationState extends State<BreathAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const double lowerBound = 0.25;
  static const double upperBound = 1.0;
  final duration = const Duration(milliseconds: 5000);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: lowerBound,
      upperBound: upperBound,
      duration: duration,
    )..repeat(reverse: true, period: duration);
  }

  // void manageAnimation() {
  //   if (!_controller.isAnimating) {
  //     _controller.stop();
  //   } else {
  //     _controller.repeat(reverse: true);
  //   }
  // }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 160 * upperBound,
        width: 160 * upperBound,
        child: _BuildBody(controller: _controller),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: _controller, curve: const _CurveWave()),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _BuildContainer(radius: 180 * _controller.value),
            _BuildContainer(radius: 140 * _controller.value),
            _BuildContainer(radius: 100 * _controller.value),
            // BackdropFilter(
            // filter: ImageFilter.blur(
            //   sigmaX: 1,
            //   sigmaY: 1,
            // ),
            //child:
            Align(
                child: Neumorphic(
              style: CustomNeumorphicStyle.neumorphicD3,
              child: InkWell(
                onTap: () {
                  _controller.isAnimating
                      ? _controller.stop()
                      : _controller.repeat();
                },
                child: CustomAnimatedButton(
                    animatedIcon: AnimatedIcons.play_pause, onTap: () {}),
              ),
            ))
          ],
        );
      },
    );
  }
}

class _BuildContainer extends StatelessWidget {
  const _BuildContainer({
    Key? key,
    required this.radius,
  }) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: CustomNeumorphicStyle.neumorphicD3,
      child: SizedBox(
        width: radius,
        height: radius,
        child: Center(
          child: Neumorphic(
            style: CustomNeumorphicStyle.neumorphicD3,
            child: SizedBox(
              width: radius - 20,
              height: radius - 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _CurveWave extends Curve {
  const _CurveWave();
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}
