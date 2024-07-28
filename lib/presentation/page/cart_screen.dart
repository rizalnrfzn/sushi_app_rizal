import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/presentation/page/payment_screen.dart';
import 'package:sushi_app/presentation/theme/palette.dart';
import 'package:sushi_app/presentation/widget/cart_item_tile.dart';
import 'package:sushi_app/provider/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    if (value.items.isEmpty)
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 2.5,
                        child: const Center(
                          child: Text('Cart is empty'),
                        ),
                      ),
                    ...value.items.map(
                      (cartItem) => CartItemTile(cartItem: cartItem),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) {
                            return route.isFirst;
                          });
                        },
                        child: Text(
                          value.items.isEmpty ? 'Add food' : 'Add more food',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Palette.textDark),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Price',
                        style: textTheme.bodyMedium!.copyWith(),
                      ),
                      const Spacer(),
                      Text(
                        'IDR ${value.totalPrice}',
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Tax and Service',
                        style: textTheme.bodyMedium!.copyWith(),
                      ),
                      const Spacer(),
                      Text(
                        'IDR ${value.totalTax}',
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Palette.textDark,
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Price',
                        style: textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        'IDR ${value.totalPrice + value.totalTax}',
                        style: textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Payment',
                      style: textTheme.bodyLarge!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
