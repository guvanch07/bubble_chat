import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/repository/chat_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> injectDataModeule(GetIt sl) async {
  /// services
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn());
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  ///repository

  sl.registerSingleton<IChatRepository>(
    ChatRepository(
      sl.get<FirebaseFirestore>(),
      sl.get<FirebaseAuth>(),
      sl.get<GoogleSignIn>(),
    ),
  );
}
