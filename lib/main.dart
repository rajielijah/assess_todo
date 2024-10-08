import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/features/tasks/presentation/screens/onboarding_screen.dart';
import 'package:todo_app/features/tasks/presentation/screens/photo_screen.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getAppTheme(),
      darkTheme: ThemeData.dark(),
      home: const OnboardingScreen(),
    );
  }
}
