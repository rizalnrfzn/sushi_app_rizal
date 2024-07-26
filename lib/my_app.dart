import 'package:flutter/material.dart';
import 'package:sushi_app/presentation/page/splash_screen.dart';
import 'package:sushi_app/presentation/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(context),
      home: const SplashScreen(),
    );
  }
}
