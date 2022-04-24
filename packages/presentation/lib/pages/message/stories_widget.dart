part of 'main_messages_page.dart';

class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Neumorphic(
        style: NeumorphicStyle(
          shadowDarkColor: Colors.black,
          shadowLightColorEmboss: AppColors.cardLight,
          shadowLightColor: AppColors.cardLight,
          shadowDarkColorEmboss: Colors.black,
          color: AppColors.cardDark,
          depth: 3,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 16),
              child: Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: AppColors.textFaded,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final faker = Faker();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 60,
                      child: _StoryCard(
                        index: index,
                        storyData: StoryData(
                          name: faker.person.firstName(),
                          url: Helpers.randomPictureUrl(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
    required this.index,
  }) : super(key: key);

  final StoryData storyData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).push(StoryScreen.route(index, storyData)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
              tag: "fake$index", child: Avatar(url: storyData.url, radius: 50)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                storyData.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
