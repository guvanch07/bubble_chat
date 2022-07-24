// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:presentation/screens/auth/bloc/auth_data.dart';
import 'package:presentation/screens/auth/bloc/auth_error.dart';
import 'package:rxdart/rxdart.dart';

extension Loading<E> on Stream<E> {
  Stream<E> setLoadingTo(
    bool isLoading, {
    required Sink<bool> onSink,
  }) =>
      doOnEach((_) => onSink.add(isLoading));
}

@immutable
class AuthBloc {
  final Stream<AuthStatus> authStatus;
  final Stream<AuthError?> authError;
  final Stream<bool> isLoading;
  final Stream<String?> userId;
  // write-only properties
  final Sink<LoginCommand> login;
  final Sink<RegisterCommand> register;
  final Sink<void> logout;
  final Sink<void> deleteAccount;

  void dispose() {
    login.close();
    register.close();
    logout.close();
    deleteAccount.close();
  }

  const AuthBloc._({
    required this.authStatus,
    required this.authError,
    required this.isLoading,
    required this.userId,
    required this.login,
    required this.register,
    required this.logout,
    required this.deleteAccount,
  });

  factory AuthBloc() {
    final isLoading = BehaviorSubject<bool>();

    // calculate auth status
    final Stream<AuthStatus> authStatus =
        FirebaseAuth.instance.authStateChanges().map((user) {
      if (user != null) {
        return const AuthStatusLoggedIn();
      } else {
        return const AuthStatusLoggedOut();
      }
    });

    // get the user-id
    final Stream<String?> userId = FirebaseAuth.instance
        .authStateChanges()
        .map((user) => user?.uid)
        .startWith(FirebaseAuth.instance.currentUser?.uid);

    // login + error handling
    final login = BehaviorSubject<LoginCommand>();

    final Stream<AuthError?> loginError = login
        .setLoadingTo(true, onSink: isLoading)
        .asyncMap<AuthError?>((loginCommand) async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginCommand.email,
          password: loginCommand.password,
        );
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (_) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, onSink: isLoading);

    // register + error handling
    final register = BehaviorSubject<RegisterCommand>();

    final Stream<AuthError?> registerError = register
        .setLoadingTo(true, onSink: isLoading)
        .asyncMap<AuthError?>((registerCommand) async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerCommand.email,
          password: registerCommand.password,
        );
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (_) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, onSink: isLoading);

    final logout = BehaviorSubject<void>();

    final Stream<AuthError?> logoutError = logout
        .setLoadingTo(true, onSink: isLoading)
        .asyncMap<AuthError?>((_) async {
      try {
        await FirebaseAuth.instance.signOut();
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (_) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, onSink: isLoading);

    // delete account

    final deleteAccount = BehaviorSubject<void>();

    final Stream<AuthError?> deleteAccountError =
        deleteAccount.setLoadingTo(true, onSink: isLoading).asyncMap((_) async {
      try {
        await FirebaseAuth.instance.currentUser?.delete();
        return null;
      } on FirebaseAuthException catch (e) {
        return AuthError.from(e);
      } catch (_) {
        return const AuthErrorUnknown();
      }
    }).setLoadingTo(false, onSink: isLoading);

    final Stream<AuthError?> authError = Rx.merge([
      loginError,
      registerError,
      logoutError,
      deleteAccountError,
    ]);

    return AuthBloc._(
        authStatus: authStatus,
        authError: authError,
        isLoading: isLoading,
        userId: userId,
        login: login,
        register: register,
        logout: logout,
        deleteAccount: deleteAccount);
  }
}
