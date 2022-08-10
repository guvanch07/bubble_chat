// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc_state.dart';
import 'package:presentation/screens/auth/app_bloc.dart';
import 'package:presentation/widgets/dialogs/generic_dialog.dart';
import 'package:domain/models/contact.dart';

class CallsPage extends BlocStateless<AppBloc> {
  CallsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<Contact>>(
        stream: bloc.contacts,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final contacts = snapshot.requireData;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts.elementAt(index);
                  return ContactListTile(
                    contact: contact,
                    deleteContact: bloc.deleteContact,
                  );
                },
              );
          }

          // return
        });
  }
}

typedef DeleteContactCallback = void Function(
  Contact contact,
);

class ContactListTile extends StatelessWidget {
  final Contact contact;
  final DeleteContactCallback deleteContact;

  const ContactListTile({
    Key? key,
    required this.contact,
    required this.deleteContact,
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
    );
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
