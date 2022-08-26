import 'package:presentation/di/injector.dart';
import 'package:get_it/get_it.dart';

Future<void> initInjector() async {
  final sl = GetIt.I;
  injectPresentationModeule(sl);
  injectDataModeule(sl);
  injectDomainModeule(sl);
}
