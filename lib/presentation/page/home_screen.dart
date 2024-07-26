import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sushi_app/models/food.dart';
import 'package:sushi_app/presentation/page/cart_screen.dart';
import 'package:sushi_app/presentation/page/detail_food_screen.dart';
import 'package:sushi_app/presentation/theme/palette.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> foods = [];
  Map<String, dynamic> food = {};

  @override
  void initState() {
    loadFoodFromJsonFile();
    super.initState();
  }

  Future<void> loadFoodFromJsonFile() async {
    String jsonString = await rootBundle.loadString('assets/json/food.json');
    List<dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      foods = jsonMap.map((json) => Food.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (foods.isEmpty) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              color: Palette.pinkMocha,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sushiman',
                style: textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Jakarta, Indonesia',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
          leading: const SizedBox(),
          leadingWidth: 0,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 16),
            promoContainer(textTheme),
            searchBar(context),
            bestSellerContainer(textTheme),
            popularFoodCarousel(textTheme),
          ],
        ),
      );
    }
  }

  Widget popularFoodCarousel(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Popular Food',
            style: textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: foods
                .map(
                  (food) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailFoodScreen(
                            food: food,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      margin: EdgeInsets.only(
                          right: 16, left: food.name == foods[0].name ? 24 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              food.imagePath,
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            food.name,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleSmall,
                          ),
                          Text(
                            food.price.toString(),
                            style: textTheme.bodyMedium!.copyWith(
                              color:
                                  textTheme.bodyMedium!.color!.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget bestSellerContainer(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Best Seller',
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Container(
            height: 170,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(foods[2].imagePath),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foods[2].name,
                  style: textTheme.titleLarge,
                ),
                Text(
                  foods[2].price.toString(),
                  style: textTheme.bodyMedium!.copyWith(
                    color: textTheme.bodyMedium!.color!.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      child: TextField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hintText: 'Search food',
          prefixIcon: const Icon(
            Icons.search,
            color: Palette.pinkMocha,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Palette.cardDark,
        ),
      ),
    );
  }

  Widget promoContainer(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Palette.cardDark,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Get 78% Promo ${foods[1].name}',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Redeem'),
                        SizedBox(width: 4),
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
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(16),
                ),
                child: Image.asset(
                  foods[1].imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
