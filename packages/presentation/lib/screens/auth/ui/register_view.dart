import 'package:domain/core/helpers/debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/core/heplers/random.dart';
import 'package:presentation/core/heplers/ui_components.dart';
import 'package:presentation/screens/auth/auth/auth_cubit.dart';
import 'package:presentation/screens/auth/credential_cubit/credential_cubit.dart';
import 'package:presentation/screens/home/ui/main_home_screen.dart';
import 'package:domain/entities/user_entity.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CredentialCubit, CredentialState>(
      listener: (context, state) {
        if (state is CredentialSuccess) {
          BlocProvider.of<AuthCubit>(context).loggedIn();
        }
        if (state is CredentialFailure) {
          AppUIHelpers.snackBarNetwork(
            context: context,
            msg: "wrong email please check",
          );
        }
      },
      builder: (context, state) {
        if (state is CredentialLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state is CredentialSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
            log('authSate');
            if (authState is Authenticated) {
              log('Authenticated');
              return HomeScreen(uid: authState.uid);
            } else {
              return const RegiterBuilder();
            }
          });
        }

        return const RegiterBuilder();
      },
    );
  }
}

class RegiterBuilder extends HookWidget {
  const RegiterBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'guvanchamanov777@gmail.com'.ifDebugging,
    );

    final passwordController = useTextEditingController(
      text: '123456'.ifDebugging,
    );
    final numberController = useTextEditingController(
      text: '123456'.ifDebugging,
    );
    final statusController = useTextEditingController(
      text: 'hey, let\'s chat'.ifDebugging,
    );

    final nameController = useTextEditingController(
      text: 'guvanch'.ifDebugging,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            IconButton(
              icon: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    context.watch<CredentialCubit>().uploadedImage ??
                        Helpers.randomPictureUrl()),
              ),
              onPressed: () =>
                  context.read<CredentialCubit>().upload("gallery"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email here...',
              ),
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your password here...',
              ),
              keyboardAppearance: Brightness.dark,
              obscureText: true,
              obscuringCharacter: '◉',
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your number here...',
              ),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(
                hintText: 'Enter your number here...',
              ),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                  hintText: 'write something some...', label: Text('status')),
            ),
            IconButton(
              onPressed: () => BlocProvider.of<CredentialCubit>(context)
                  .googleSignInUseCase(),
              icon: const Icon(
                Icons.login,
                size: 40,
              ),
            ),
            TextButton(
              onPressed: () {
                if (emailController.text.isEmpty) return;
                if (passwordController.text.isEmpty) return;
                BlocProvider.of<CredentialCubit>(context, listen: false)
                    .signUpSubmit(
                  user: UserEntity(
                    email: emailController.text,
                    phoneNumber: numberController.text,
                    name: nameController.text,
                    profileUrl:
                        BlocProvider.of<CredentialCubit>(context, listen: false)
                                .uploadedImage ??
                            Helpers.randomPictureUrl(),
                    gender: '',
                    dob: '',
                    password: passwordController.text,
                    isOnline: false,
                    status: "Hi! there i'm using this app",
                  ),
                );
              },
              child: const Text(
                'Register',
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Already registered? Log in here!',
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.image_aspect_ratio_sharp))
          ],
        ),
      ),
    );
  }
}
