import 'package:sushi_app/models/food.dart';

class CartItem {
  final Food food;
  final int quantity;

  CartItem({
    required this.food,
    required this.quantity,
  });

  int get totalPrice => food.price * quantity;
}
