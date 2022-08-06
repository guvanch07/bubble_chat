// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:domain/core/enums/current_view.dart';
import 'package:flutter/foundation.dart';
import 'package:presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:presentation/screens/auth/bloc/auth_data.dart';
import 'package:presentation/screens/auth/bloc/auth_error.dart';
import 'package:presentation/screens/auth/current_bloc.dart';
import 'package:presentation/screens/home/ui/greate_user/bloc/create_user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/models/contact.dart';

@immutable
class AppBloc {
  final AuthBloc _authBloc;
  final ViewsBloc _viewsBloc;
  final CreateUserBloc _createUserBloc;

  final Stream<CurrentView> currentView;
  final Stream<bool> isLoading;
  final Stream<AuthError?> authError;
  final StreamSubscription<String?> _userIdChanges;

  factory AppBloc() {
    final authBloc = AuthBloc();
    final viewsBloc = ViewsBloc();
    final contactsBloc = CreateUserBloc();

    // pass userid from auth bloc into the contacts bloc

    final userIdChanges = authBloc.userId.listen((String? userId) {
      contactsBloc.userId.add(userId);
    });

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
      contactsBloc: contactsBloc,
      currentView: currentView,
      isLoading: isLoading.asBroadcastStream(),
      authError: authBloc.authError.asBroadcastStream(),
      userIdChanges: userIdChanges,
    );
  }

  void dispose() {
    _authBloc.dispose();
    _viewsBloc.dispose();
    _createUserBloc.dispose();
    _userIdChanges.cancel();
  }

  const AppBloc._({
    required AuthBloc authBloc,
    required ViewsBloc viewsBloc,
    required CreateUserBloc contactsBloc,
    required this.currentView,
    required this.isLoading,
    required this.authError,
    required StreamSubscription<String?> userIdChanges,
  })  : _authBloc = authBloc,
        _viewsBloc = viewsBloc,
        _createUserBloc = contactsBloc,
        _userIdChanges = userIdChanges;

  void deleteContact(Contact contact) {
    _createUserBloc.deleteContact.add(
      contact,
    );
  }

  void createContact(
    String firstName,
    String lastName,
    String phoneNumber,
  ) {
    _createUserBloc.createContact.add(
      Contact.withoutId(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      ),
    );
  }

  void deleteAccount() {
    _createUserBloc.deleteAllContacts.add(null);
    _authBloc.deleteAccount.add(null);
  }

  void logout() {
    _authBloc.logout.add(
      null,
    );
  }

  Stream<Iterable<Contact>> get contacts => _createUserBloc.contacts;

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
