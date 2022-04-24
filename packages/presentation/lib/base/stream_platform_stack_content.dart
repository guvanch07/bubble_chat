import 'package:flutter/material.dart';
import 'bloc_data.dart';

class StreamPlatformStackContent<SD> extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Stream<BlocData<SD?>> dataStream;
  final dynamic Function(BlocData<SD?> data) children;
  final AppBar? Function(BlocData<SD?> data)? appBar;
  final Widget Function(BlocData<SD?> data)? bottomNavigation;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  const StreamPlatformStackContent({
    Key? key,
    required this.dataStream,
    required this.children,
    this.scaffoldKey,
    this.appBar,
    this.bottomNavigation,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData<SD?>>(
      stream: dataStream,
      initialData: BlocData.init(),
      builder: (context, result) {
        final data = result.data;
        final child = <Widget>[];
        if (data != null) {
          final funcChild = children.call(data);
          if (funcChild is List<Widget>) {
            child.addAll(funcChild);
          } else if (funcChild is Widget) {
            child.add(funcChild);
          }
          return IgnorePointer(
            ignoring: data.isLoading,
            child: Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              appBar: appBar?.call(data),
              backgroundColor: backgroundColor,
              body: Stack(
                children: child,
              ),
              bottomNavigationBar: bottomNavigation?.call(data),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
