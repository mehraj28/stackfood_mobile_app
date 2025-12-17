import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_model.dart';
import '../providers/cart_provider.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(food.image, height: 100, fit: BoxFit.cover),
          Text(food.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text("₹${food.price}"),
          ElevatedButton(
            onPressed: () {
              context.read<CartProvider>().addToCart(food);
            },
            child: Text("Add to Cart"),
          )
        ],
      ),
    );
  }
}
