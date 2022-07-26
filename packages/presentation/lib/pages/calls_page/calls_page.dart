import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/screens/auth/app_bloc.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I.get<AppBloc>();
    return Center(
        child: CupertinoButton.filled(
            child: const Text("log out"),
            onPressed: () {
              getIt.logout();
              getIt.deleteAccount();
            }));
  }
}
