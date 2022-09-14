// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../main_home_screen.dart';

class _CustomBottomSheet extends HookWidget {
  const _CustomBottomSheet({
    Key? key,
    // required this.createContact,
    // required this.goBack,
  }) : super(key: key);

  // final CreateContactCallback createContact;
  // final VoidCallback goBack;

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController(
      text: 'Vandad'.ifDebugging,
    );
    final lastNameController = useTextEditingController(
      text: 'Nahavandipoor'.ifDebugging,
    );
    final phoneNumberController = useTextEditingController(
      text: '+461234567890'.ifDebugging,
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Neumorphic(
        style: NeumorphicStyle(
          shadowDarkColor: Colors.black,
          shadowLightColorEmboss: AppColors.cardLight,
          shadowLightColor: AppColors.cardLight,
          shadowDarkColorEmboss: Colors.black,
          color: AppColors.cardDark,
          depth: 3,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAnimatedButton(
                    animatedIcon: AnimatedIcons.view_list,
                    onTap: () {},
                  ),
                  CustomAnimatedButton(
                    animatedIcon: AnimatedIcons.close_menu,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                    hintText: 'First name...', fillColor: AppColors.accent),
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.dark,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                    hintText: 'Last name...', fillColor: AppColors.accent),
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.dark,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                    hintText: 'Phone number...', fillColor: AppColors.accent),
                keyboardType: TextInputType.phone,
                keyboardAppearance: Brightness.dark,
              ),
              TextButton(
                onPressed: () {
                  // final firstName = firstNameController.text;
                  // final lastName = lastNameController.text;
                  // final phoneNumber = phoneNumberController.text;
                  // createContact(
                  //   firstName,
                  //   lastName,
                  //   phoneNumber,
                  // );
                  Navigator.pop(context);
                  //goBack();
                },
                child: const Text(
                  'Save Contact',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
