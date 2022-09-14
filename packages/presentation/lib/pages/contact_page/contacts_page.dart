// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({
    Key? key,
    //required this.bloc,
  }) : super(key: key);
  //final AppBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton.filled(
            child: const Text("dsds"),
            onPressed: () {
              //bloc.logout();
            })
      ],
    );
  }
}
