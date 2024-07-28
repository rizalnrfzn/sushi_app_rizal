import 'package:flutter/material.dart';
import 'package:sushi_app/models/cart_item.dart';

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalPrice =>
      _items.fold(0, (total, item) => total + item.totalPrice);

  int get totalTax => (totalPrice * 0.1).round();

  void addToCart(CartItem item) {
    if (_items.any(
      (element) => element.food == item.food,
    )) {
      _items
          .firstWhere(
            (element) => element.food == item.food,
          )
          .quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void add(CartItem item) {
    item.addQuantity();
    notifyListeners();
  }

  void remove(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }

    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
