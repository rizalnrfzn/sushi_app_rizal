import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_app/models/cart_item.dart';
import 'package:sushi_app/models/food.dart';
import 'package:sushi_app/presentation/page/cart_screen.dart';
import 'package:sushi_app/presentation/theme/palette.dart';
import 'package:sushi_app/presentation/widget/cart_icon.dart';
import 'package:sushi_app/provider/cart.dart';

class DetailFoodScreen extends StatefulWidget {
  const DetailFoodScreen({super.key, required this.food});

  final Food food;

  @override
  State<DetailFoodScreen> createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  expandedHeight: 400,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(widget.food.name),
                    titlePadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    centerTitle: false,
                    background: Image.asset(
                      widget.food.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: const [
                    CartIcon(),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Price'),
                                Text(
                                  '${widget.food.price.toString()} IDR',
                                  style: textTheme.headlineSmall,
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_outline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...List.generate(
                                5,
                                (index) => const Icon(
                                  Icons.star,
                                  color: Palette.yellowMocha,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.food.rating.toString(),
                                style: textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.food.description,
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 24,
            ),
            decoration: const BoxDecoration(
              color: Palette.cardDark,
            ),
            child: Row(
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      if (quantity > 0) {
                        quantity--;
                      }
                    });
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 6),
                Text(
                  '$quantity',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 6),
                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: InkWell(
                    onTap: quantity <= 0
                        ? null
                        : () {
                            context.read<Cart>().addToCart(
                                  CartItem(
                                      food: widget.food, quantity: quantity),
                                );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.pinkMocha.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.food.price * quantity} IDR',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'Add to cart',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
