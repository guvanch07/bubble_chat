import 'package:flash_chat/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:presentation/main_app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}
