import 'dart:async';

import 'package:flutter/material.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/screens/auth/app_bloc.dart';
import 'package:presentation/screens/auth/bloc/auth_error.dart';
import 'package:presentation/screens/auth/ui/login_view.dart';
import 'package:presentation/screens/auth/ui/register_view.dart';
import 'package:presentation/widgets/dialogs/auth_error_dialog.dart';
import 'package:presentation/widgets/loading/loading_screen.dart';
import 'package:domain/core/enums/current_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AppBloc appBloc;
  StreamSubscription<AuthError?>? _authErrorSub;
  StreamSubscription<bool>? _isLoadingSub;

  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
  }

  @override
  void dispose() {
    appBloc.dispose();
    _authErrorSub?.cancel();
    _isLoadingSub?.cancel();
    super.dispose();
  }

  void handleAuthErrors(BuildContext context) async {
    await _authErrorSub?.cancel();
    _authErrorSub = appBloc.authError.listen((event) {
      final AuthError? authError = event;
      if (authError == null) {
        return;
      }
      showAuthError(
        authError: authError,
        context: context,
      );
    });
  }

  void setupLoadingScreen(BuildContext context) async {
    await _isLoadingSub?.cancel();
    _isLoadingSub = appBloc.isLoading.listen((isLoading) {
      if (isLoading) {
        LoadingScreen.instance().show(
          context: context,
          text: 'Loading...',
        );
      } else {
        LoadingScreen.instance().hide();
      }
    });
  }

  Widget getHomePage() {
    return StreamBuilder<CurrentView>(
      stream: appBloc.currentView,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            final currentView = snapshot.requireData;
            switch (currentView) {
              case CurrentView.login:
                return LoginView(
                  login: appBloc.login,
                  goToRegisterView: appBloc.goToRegisterView,
                );
              case CurrentView.register:
                return RegisterView(
                  register: appBloc.register,
                  goToLoginView: appBloc.goToLoginView,
                );

              case CurrentView.home:
                return const HomeScreen();
              case CurrentView.createContact:
                return Container(
                  color: Colors.amber,
                );
            }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    handleAuthErrors(context);
    setupLoadingScreen(context);
    return getHomePage();
  }
}
