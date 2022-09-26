import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/pages/contact_page/cubit/user_cubit.dart';
import 'package:presentation/pages/message/cubit/messages_cubit.dart';
import 'package:presentation/screens/auth/auth/auth_cubit.dart';
import 'package:presentation/screens/auth/credential_cubit/credential_cubit.dart';
import 'package:presentation/screens/auth/ui/login_view.dart';
import 'package:presentation/screens/chat/cubit/chat_messages_cubit.dart';
import 'package:presentation/screens/home/ui/main_home_screen.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => GetIt.I.get<AuthCubit>()..appStarted()),
        BlocProvider(create: (context) => GetIt.I.get<CredentialCubit>()),
        BlocProvider(create: (context) => GetIt.I.get<UserCubit>()..getUsers()),
        BlocProvider(create: (context) => GetIt.I.get<MessagesCubit>()),
        BlocProvider(create: (context) => GetIt.I.get<ChatMessagesCubit>()),
        // BlocProvider(create: (context) => BottomNavCubit(0)),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated) {
              return HomeScreen(uid: authState.uid);
            } else {
              return const LoginView();
            }
          },
        ),
      ),
    );
  }
}
