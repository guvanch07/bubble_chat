// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:presentation/base/base_bloc.dart';
import 'package:presentation/base/impl_base_bloc.dart';

abstract class AuthNewBloc extends BaseBloc {
  factory AuthNewBloc(
    FirebaseAuth firebaseAuth,
  ) =>
      _AuthNewBloc(
        firebaseAuth,
      );

  Future<UserCredential> signInWithGoogle();
  void registerPage(String email, String password);
  Stream<User?> authStateChanges();
  logOut();
}

class _AuthNewBloc extends BlocImpl implements AuthNewBloc {
  final FirebaseAuth _firebaseAuth;

  _AuthNewBloc(
    this._firebaseAuth,
  );

//!google
  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final firebaseSignIn = await _firebaseAuth.signInWithCredential(credential);

    return firebaseSignIn;
  }

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void registerPage(String email, String password) async {
    try {
      final User? firebaseAuth = (await _firebaseAuth
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      if (firebaseAuth != null) {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
