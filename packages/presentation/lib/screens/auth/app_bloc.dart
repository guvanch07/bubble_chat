// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:domain/core/enums/current_view.dart';
import 'package:presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:presentation/screens/auth/bloc/auth_data.dart';
import 'package:presentation/screens/auth/bloc/auth_error.dart';
import 'package:presentation/screens/auth/current_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc {
  final AuthBloc _authBloc;
  final ViewsBloc _viewsBloc;

  final Stream<CurrentView> currentView;
  final Stream<bool> isLoading;
  final Stream<AuthError?> authError;
  //final StreamSubscription<String?> _userIdChanges;

  factory AppBloc() {
    final authBloc = AuthBloc();
    final viewsBloc = ViewsBloc();

    // calculate the current view
    final Stream<CurrentView> currentViewBasedOnAuthStatus =
        authBloc.authStatus.map<CurrentView>((authStatus) {
      if (authStatus is AuthStatusLoggedIn) {
        return CurrentView.home;
      } else {
        return CurrentView.login;
      }
    });

    // current view

    final Stream<CurrentView> currentView = Rx.merge([
      currentViewBasedOnAuthStatus,
      viewsBloc.currentView,
    ]);

    // isLoading

    final Stream<bool> isLoading = Rx.merge([
      authBloc.isLoading,
    ]);

    return AppBloc._(
      authBloc: authBloc,
      viewsBloc: viewsBloc,
      currentView: currentView,
      isLoading: isLoading.asBroadcastStream(),
      authError: authBloc.authError.asBroadcastStream(),
    );
  }

  AppBloc._({
    required AuthBloc authBloc,
    required ViewsBloc viewsBloc,
    required this.currentView,
    required this.isLoading,
    required this.authError,
    //required StreamSubscription<String?> userIdChanges,
  })  : _authBloc = authBloc,
        _viewsBloc = viewsBloc;
  //_userIdChanges = userIdChanges;

  void dispose() {
    _authBloc.dispose();
    _viewsBloc.dispose();
  }

  void logout() {
    _authBloc.logout.add(
      null,
    );
  }

  void deleteAccount() {
    _authBloc.deleteAccount.add(null);
  }

  void register(
    String email,
    String password,
  ) {
    _authBloc.register.add(
      RegisterCommand(
        email: email,
        password: password,
      ),
    );
  }

  void login(
    String email,
    String password,
  ) {
    _authBloc.login.add(
      LoginCommand(
        email: email,
        password: password,
      ),
    );
  }

  void goToContactListView() => _viewsBloc.goToView.add(
        CurrentView.home,
      );

  void goToCreateContactView() => _viewsBloc.goToView.add(
        CurrentView.createContact,
      );

  void goToRegisterView() => _viewsBloc.goToView.add(
        CurrentView.register,
      );

  void goToLoginView() => _viewsBloc.goToView.add(
        CurrentView.login,
      );
}
