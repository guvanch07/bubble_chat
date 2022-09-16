import 'package:domain/core/helpers/debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/screens/auth/auth/auth_cubit.dart';
import 'package:presentation/screens/auth/credential_cubit/credential_cubit.dart';
import 'package:presentation/screens/home/ui/main_home_screen.dart';
import 'package:domain/entities/user_entity.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in',
        ),
      ),
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, state) {
          if (state is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (state is CredentialFailure) {
            log('error');
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
                return HomeScreen();
              } else {
                return const RegiterBuilder();
              }
            });
          }

          return const RegiterBuilder();
        },
      ),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
            TextButton(
              onPressed: () {
                if (emailController.text.isEmpty) return;
                if (passwordController.text.isEmpty) return;
                BlocProvider.of<CredentialCubit>(context).signUpSubmit(
                  user: UserEntity(
                    email: emailController.text,
                    phoneNumber: '',
                    name: emailController.text.split('@').join(),
                    profileUrl: '',
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
