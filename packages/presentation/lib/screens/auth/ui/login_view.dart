import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:domain/core/helpers/debugging.dart';
import 'package:presentation/screens/auth/auth/auth_cubit.dart';
import 'package:presentation/screens/auth/credential_cubit/credential_cubit.dart';
import 'package:presentation/screens/auth/ui/register_view.dart';
import 'package:presentation/screens/home/ui/main_home_screen.dart';

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
              if (authState is Authenticated) {
                return HomeScreen(uid: authState.uid);
              } else {
                return const LoginBuilder();
              }
            });
          }

          return const LoginBuilder();
        },
      ),
    );
  }
}

class LoginBuilder extends HookWidget {
  const LoginBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'guvanch.com'.ifDebugging,
    );

    final passwordController = useTextEditingController(
      text: '1234567'.ifDebugging,
    );
    return Padding(
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
              if (emailController.text.isEmpty) {
                log(emailController.text);
                return;
              }
              if (passwordController.text.isEmpty) {
                log(passwordController.text);
                return;
              }
              BlocProvider.of<CredentialCubit>(context).signInSubmit(
                email: emailController.text,
                password: passwordController.text,
              );
            },
            child: const Text(
              'Log in',
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RegiterBuilder())),
            child: const Text(
              'Not registered yet? Register here!',
            ),
          ),
        ],
      ),
    );
  }
}
