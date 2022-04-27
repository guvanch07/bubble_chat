import 'package:flutter/material.dart';
import 'package:presentation/widgets/animation/wave_animation.dart';

class MusicPage extends StatelessWidget {
  MusicPage({Key? key}) : super(key: key);
  final breathAnimationStateKey = GlobalKey<BreathAnimationState>();

  @override
  Widget build(BuildContext context) {
    return BreathAnimation(
      key: breathAnimationStateKey,
    );
  }
}
