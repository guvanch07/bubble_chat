import 'package:get_it/get_it.dart';
import 'package:presentation/pages/message/bloc/bloc.dart';
import 'package:presentation/screens/auth/app_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presentation/services/auth_bloc.dart';

Future<void> injectPresentationModeule(GetIt sl) async {
  /// servicees

  /// blocs
  sl.registerFactory<AppBloc>(
    () => AppBloc(
      sl.get<FirebaseAuth>(),
    ),
  );
}
