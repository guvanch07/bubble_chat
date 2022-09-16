// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/models/contact.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:presentation/base/bloc_state.dart';
import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/screens/chat/ui/main_chat_screen.dart';
import 'package:presentation/widgets/dialogs/generic_dialog.dart';
import 'package:domain/models/message_data.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Faker faker = Faker();
    final date = Helpers.randomDate();

    final msg = MessageData(
      senderName: faker.person.name(),
      message: faker.lorem.sentence(),
      messageDate: date,
      dateMessage: Jiffy(date).fromNow(),
      profilePicture: Helpers.randomPictureUrl(),
    );
    return Container();
  }
}

typedef DeleteContactCallback = void Function(
  Contact contact,
);

class ContactListTile extends StatelessWidget {
  final Contact contact;
  final DeleteContactCallback deleteContact;
  final VoidCallback showDetils;

  const ContactListTile({
    Key? key,
    required this.contact,
    required this.deleteContact,
    required this.showDetils,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(contact.fullName),
        trailing: IconButton(
          onPressed: () async {
            final shouldDelete = await showDeleteContactDialog(context);
            if (shouldDelete) {
              deleteContact(contact);
            }
          },
          icon: const Icon(Icons.delete),
        ),
        onTap: showDetils);
  }
}

Future<bool> showDeleteContactDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete contact',
    content:
        'Are you sure you want to delete this contact? You cannot undo this operation!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete contact': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
