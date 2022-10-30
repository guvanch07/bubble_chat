import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  static Route route(int index, String url) => MaterialPageRoute(
        builder: (context) => StoryScreen(index: index, url: url),
      );

  const StoryScreen({
    Key? key,
    required this.index,
    required this.url,
  }) : super(key: key);

  final int index;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Hero(
          tag: "fake$index",
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(url),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
