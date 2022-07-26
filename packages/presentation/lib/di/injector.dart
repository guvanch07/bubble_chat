import 'package:get_it/get_it.dart';
import 'package:presentation/screens/auth/app_bloc.dart';

Future<void> injectPresentationModeule(GetIt sl) async {
  sl.registerFactory<AppBloc>(() => AppBloc());
}
