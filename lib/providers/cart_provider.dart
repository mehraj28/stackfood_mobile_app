// import 'package:flutter/material.dart';
// import '../models/cart_item_model.dart';
// import '../models/food_model.dart';

// class CartProvider extends ChangeNotifier {
//   final Map<int, CartItem> _items = {};

//   Map<int, CartItem> get items => _items;

//   void addToCart(Food food) {
//     if (_items.containsKey(food.id)) {
//       _items[food.id]!.quantity++;
//     } else {
//       _items[food.id] = CartItem(food: food);
//     }
//     notifyListeners();
//   }

//   void removeFromCart(int foodId) {
//     _items.remove(foodId);
//     notifyListeners();
//   }

//   void decreaseQty(int foodId) {
//     if (_items[foodId]!.quantity > 1) {
//       _items[foodId]!.quantity--;
//     } else {
//       removeFromCart(foodId);
//     }
//     notifyListeners();
//   }

//   double get totalPrice {
//     double total = 0;
//     _items.forEach((key, item) {
//       total += item.food.price * item.quantity;
//     });
//     return total;
//   }

//   int get totalItems =>
//       _items.values.fold(0, (sum, item) => sum + item.quantity);
// }

import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/food_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _items = {};

  // ================= GETTERS =================
  Map<int, CartItem> get items => _items;

  bool get isEmpty => _items.isEmpty;

  // ================= ADD TO CART =================
  void addToCart(Food food) {
    if (_items.containsKey(food.id)) {
      _items[food.id]!.quantity++;
    } else {
      _items[food.id] = CartItem(food: food, quantity: 1);
    }
    notifyListeners();
  }

  // ================= INCREASE =================
  void increaseQty(int foodId) {
    if (_items.containsKey(foodId)) {
      _items[foodId]!.quantity++;
      notifyListeners();
    }
  }

  // ================= DECREASE =================
  void decreaseQty(int foodId) {
    if (!_items.containsKey(foodId)) return;

    if (_items[foodId]!.quantity > 1) {
      _items[foodId]!.quantity--;
    } else {
      _items.remove(foodId);
    }
    notifyListeners();
  }

  // ================= REMOVE =================
  void removeFromCart(int foodId) {
    _items.remove(foodId);
    notifyListeners();
  }

  // ================= CLEAR =================
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // ================= TOTAL PRICE =================
  double get totalPrice {
    double total = 0;
    for (final item in _items.values) {
      total += item.food.price * item.quantity;
    }
    return total;
  }

  // ================= TOTAL ITEMS (IMPORTANT FIX) =================
  int get totalItems {
    int count = 0;
    for (final item in _items.values) {
      count += item.quantity;
    }
    return count;
  }

  // ================= ORDER PAYLOAD =================
  List<Map<String, dynamic>> toOrderItems() {
    return _items.values.map((item) {
      return {
        "food_id": item.food.id,
        "quantity": item.quantity,
        "price": item.food.price,
      };
    }).toList();
  }
}
