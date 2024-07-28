import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/presentation/theme/palette.dart';
import 'package:sushi_app/provider/cart.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var rng = Random();
  late int vaNumber;
  @override
  void initState() {
    vaNumber = rng.nextInt(900000000) + 100000000;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge!.copyWith(
          color: Palette.pinkMocha,
        ),
      ),
      body: Consumer<Cart>(builder: (context, value, child) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...value.items.map(
                      (e) => ListTile(
                        title: Text(e.food.name),
                        subtitle:
                            Text('Price: ${e.quantity} x ${e.food.price} IDR'),
                        trailing: Text('${e.quantity * e.food.price} IDR'),
                        leadingAndTrailingTextStyle: textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'VA Number: $vaNumber',
              style: textTheme.titleLarge,
            ),
            FilledButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: '$vaNumber'));
              },
              child: const Text('Copy VA Number'),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
          ],
        );
      }),
    );
  }
}
