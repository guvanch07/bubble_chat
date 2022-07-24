import 'package:faker/faker.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:jiffy/jiffy.dart';

import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:domain/models/message_data.dart';
import 'package:domain/models/story_data.dart';
import 'package:presentation/screens/chat/ui/main_chat_screen.dart';
import 'package:presentation/screens/story/main_story.dart';
import 'package:presentation/widgets/avatar.dart';
import 'package:presentation/widgets/icon_avatar.dart';

part 'stories_widget.dart';
part 'message_tile.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: _Stories()),
        SliverList(delegate: SliverChildBuilderDelegate(_delegate))
      ],
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
    return _MessageTile(
      messageData: MessageData(
        senderName: faker.person.name(),
        message: faker.lorem.sentence(),
        messageDate: date,
        dateMessage: Jiffy(date).fromNow(),
        profilePicture: Helpers.randomPictureUrl(),
      ),
    );
  }
}
