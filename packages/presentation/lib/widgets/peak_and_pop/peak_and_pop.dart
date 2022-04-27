import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeekAndPop extends StatelessWidget {
  const PeekAndPop({
    Key? key,
    required this.child,
    required this.showPeekAndPop,
    required this.height,
    required this.width,
    this.paddingVertical,
    this.paddingHorizontal,
  }) : super(key: key);
  final Widget child;
  final Widget showPeekAndPop;
  final double height;
  final double width;
  final double? paddingVertical;
  final double? paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    final layers = <Widget>[];

    layers.add(child);

    if (context.watch<PeekAndPopLogic>().dialogVisiblte) {
      layers.add(_buildDialog());
    }

    return Listener(
      onPointerDown: context.read<PeekAndPopLogic>().onPointerDown,
      onPointerUp: context.read<PeekAndPopLogic>().onPointerUp,
      child: Center(
        child: Stack(
          children: layers,
        ),
      ),
    );
  }

  Widget _buildDialog() {
    return Container(
      width: width,
      height: height,
      color: Colors.black.withOpacity(0.5),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal ?? 0,
        vertical: paddingVertical ?? 0,
      ),
      child: showPeekAndPop,
    );
  }
}

class PeekAndPopLogic with ChangeNotifier {
  Timer? _showDialogTimer;
  bool _dialogVisible = false;

  bool get dialogVisiblte => _dialogVisible;

  @override
  void dispose() {
    _showDialogTimer?.cancel();
    super.dispose();
  }

  void onPointerDown(PointerDownEvent event) {
    _showDialogTimer = Timer(const Duration(milliseconds: 300), _showDialog);
  }

  void onPointerUp(PointerUpEvent event) {
    _showDialogTimer?.cancel();
    _showDialogTimer = null;

    _dialogVisible = false;
    notifyListeners();
  }

  void _showDialog() {
    _dialogVisible = true;
    notifyListeners();
  }
}
