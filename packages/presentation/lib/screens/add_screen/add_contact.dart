import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:presentation/core/heplers/random.dart';

class AddNewContacts extends HookWidget {
  const AddNewContacts({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (context) => const AddNewContacts(),
      );

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final numberController = useTextEditingController();

    return Scaffold(
        appBar: AppBar(elevation: 0),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(Helpers.randomPictureUrl()),
                    radius: 70,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: [
                        TextField(controller: nameController),
                        TextField(controller: lastNameController),
                      ],
                    ),
                  ),
                ],
              ),
              TextField(
                controller: numberController,
                keyboardType: TextInputType.number,
              ),
              const Spacer(),
              CupertinoButton.filled(
                  child: const Text('Add Contact'),
                  onPressed: () => Navigator.pop(context)),
              const SizedBox(height: 50),
            ],
          ),
        ));
  }
}
