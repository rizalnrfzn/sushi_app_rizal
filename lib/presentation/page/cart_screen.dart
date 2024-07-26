import 'package:flutter/material.dart';
import 'package:sushi_app/models/cart_item.dart';
import 'package:sushi_app/models/food.dart';
import 'package:sushi_app/presentation/theme/palette.dart';

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  cartListTile(
                    CartItem(
                      food: Food(
                        name: 'Inarizushi',
                        description: 'description',
                        price: 128,
                        imagePath: 'assets/images/inarizushi.jpg',
                        rating: 4.5,
                      ),
                      quantity: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Add more food'),
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
                      'IDR 128',
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
                      'IDR 12',
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
                      'IDR 12',
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
              onPressed: () {},
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
      ),
    );
  }

  Padding cartListTile(CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          cartItem.food.name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        subtitle: Text(
          '${cartItem.quantity} x ${cartItem.food.price} IDR',
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            cartItem.food.imagePath,
            fit: BoxFit.cover,
            height: 56,
            width: 56,
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.remove_circle_outline,
            color: Palette.pinkMocha,
          ),
        ),
      ),
    );
  }
}
