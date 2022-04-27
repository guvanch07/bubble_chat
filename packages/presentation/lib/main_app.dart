import 'package:flutter/material.dart';
import 'package:presentation/core/theme/theme.dart';
import 'package:presentation/screens/home/ui/main_home_screen.dart';
import 'package:presentation/widgets/peak_and_pop/peak_and_pop.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PeekAndPopLogic(),
      child: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.dark,
        title: 'Chatter',
        home: HomeScreen(),
      ),
    );
  }
}
