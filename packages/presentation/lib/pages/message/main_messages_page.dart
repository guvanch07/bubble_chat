import 'package:faker/faker.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:presentation/base/bloc_state.dart';
import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:domain/models/story_data.dart';
import 'package:presentation/pages/message/bloc/bloc.dart';
import 'package:presentation/screens/story/main_story.dart';
import 'package:presentation/widgets/avatar.dart';
import 'package:presentation/widgets/icon_avatar.dart';

part 'stories_widget.dart';
part 'message_tile.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [_Stories(), _BuildWidget()],
    );
  }
}

class _BuildWidget extends StatefulWidget {
  const _BuildWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_BuildWidget> createState() => _BuildWidgetState();
}

class _BuildWidgetState extends BlocState<_BuildWidget, UserChatListBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();
    return _MessageTile(
      faker: faker,
    );
  }
}
