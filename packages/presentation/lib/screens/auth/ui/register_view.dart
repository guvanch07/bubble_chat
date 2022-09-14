// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/core/helpers/debugging.dart';
import 'package:domain/core/typedefs/login_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:presentation/services/auth_bloc.dart';

class RegisterView extends HookWidget {
  final AuthNewBloc bloc;

  const RegisterView({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'vandad.np@gmail.com'.ifDebugging,
    );

    final passwordController = useTextEditingController(
      text: 'foobarbaz'.ifDebugging,
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
                final email = emailController.text;
                final password = passwordController.text;
                bloc.registerPage(
                  email,
                  password,
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
                onPressed: () => bloc.signInWithGoogle(),
                icon: const Icon(Icons.image_aspect_ratio_sharp))
          ],
        ),
      ),
    );
  }
}
