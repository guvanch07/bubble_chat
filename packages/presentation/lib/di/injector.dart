import 'package:get_it/get_it.dart';
import 'package:presentation/screens/auth/auth/auth_cubit.dart';
import 'package:presentation/screens/auth/credential_cubit/credential_cubit.dart';

Future<void> injectPresentationModeule(GetIt sl) async {
  /// servicees

  /// blocs
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      isSignInUseCase: sl.get(),
      signOutUseCase: sl.get(),
      getCurrentUIDUseCase: sl.get(),
    ),
  );

  sl.registerFactory<CredentialCubit>(
    () => CredentialCubit(
      forgotPasswordUseCase: sl.get(),
      getCreateCurrentUserUseCase: sl.get(),
      googleSignInUseCase: sl.get(),
      signInUseCase: sl.get(),
      signUpUseCase: sl.get(),
    ),
  );
}
