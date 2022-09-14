import 'package:presentation/di/injector.dart';
import 'package:get_it/get_it.dart';
import 'package:data/di/injector.dart';
import 'package:domain/di/injector.dart';

Future<void> initInjector() async {
  final sl = GetIt.I;
  await injectPresentationModeule(sl);
  await injectDataModeule(sl);
  await injectDomainModeule(sl);
}
