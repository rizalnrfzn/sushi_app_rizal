import 'package:sushi_app/models/food.dart';

class CartItem {
  final Food food;
  int quantity;

  CartItem({
    required this.food,
    required this.quantity,
  });

  void addQuantity() {
    quantity++;
  }

  int get totalPrice => food.price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        food: Food.fromJson(json['food']),
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'food': food.toJson(),
        'quantity': quantity,
      };
}
