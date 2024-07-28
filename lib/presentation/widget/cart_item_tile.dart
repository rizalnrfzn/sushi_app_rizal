import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/models/cart_item.dart';
import 'package:sushi_app/provider/cart.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.food.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    '${cartItem.quantity} x ${cartItem.food.price} IDR',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(0.7),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 24,
              width: 24,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  context.read<Cart>().remove(cartItem);
                },
                child: const Icon(
                  Icons.add,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '${cartItem.quantity}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 6),
            SizedBox(
              height: 24,
              width: 24,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  context.read<Cart>().add(cartItem);
                },
                child: const Icon(
                  Icons.remove,
                  size: 18,
                ),
              ),
            ),
          ],
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
      ),
    );
  }
}
