import 'package:flutter/material.dart';
import 'package:sushi_app/presentation/page/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sushi_background.jpg'),
            opacity: 0.7,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
              ),
              child: Text(
                'Sushiman',
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'JAPANESE TASTE OF JAPANESE FOOD',
              style: textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Feel the taste of the most popular Japanese food form anywhere and anytimr',
              style: textTheme.bodyMedium!.copyWith(
                color: textTheme.bodyMedium!.color!.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get Started',
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
