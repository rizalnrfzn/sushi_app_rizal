import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/presentation/page/splash_screen.dart';
import 'package:sushi_app/presentation/theme/theme.dart';
import 'package:sushi_app/provider/cart.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(context),
        home: const SplashScreen(),
      ),
    );
  }
}
