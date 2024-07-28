import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/presentation/page/cart_screen.dart';
import 'package:sushi_app/provider/cart.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, value, child) {
      return IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CartScreen(),
            ),
          );
        },
        icon: Badge(
          isLabelVisible: value.items.isNotEmpty,
          offset: const Offset(8, -6),
          label: Text('${value.items.length}'),
          child: const Icon(Icons.shopping_cart_outlined),
        ),
      );
    });
  }
}
