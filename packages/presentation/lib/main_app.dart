import 'dart:async';

import 'package:flutter/material.dart';
import 'package:presentation/base/bloc_state.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/screens/auth/app_bloc.dart';
import 'package:presentation/screens/auth/bloc/auth_error.dart';
import 'package:presentation/screens/auth/ui/login_view.dart';
import 'package:presentation/screens/auth/ui/register_view.dart';
import 'package:presentation/screens/home/ui/main_home_screen.dart';
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
      debugShowCheckedModeBanner: false,
      home: const MainAppPage(),
    );
  }
}

class MainAppPage extends StatefulWidget {
  const MainAppPage({Key? key}) : super(key: key);

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends BlocState<MainAppPage, AppBloc> {
  StreamSubscription<AuthError?>? _authErrorSub;
  StreamSubscription<bool>? _isLoadingSub;

  @override
  void initState() {
    super.initState();
    bloc;
  }

  @override
  void dispose() {
    bloc.dispose();
    _authErrorSub?.cancel();
    _isLoadingSub?.cancel();
    super.dispose();
  }

  void handleAuthErrors(BuildContext context) async {
    await _authErrorSub?.cancel();
    _authErrorSub = bloc.authError.listen((event) {
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
    _isLoadingSub = bloc.isLoading.listen((isLoading) {
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
      stream: bloc.currentView,
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
                  login: bloc.login,
                  goToRegisterView: bloc.goToRegisterView,
                );
              case CurrentView.register:
                return RegisterView(
                  register: bloc.register,
                  goToLoginView: bloc.goToLoginView,
                );

              case CurrentView.home:
                return HomeScreen(bloc: bloc);
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
