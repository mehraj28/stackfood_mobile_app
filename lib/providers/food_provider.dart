import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../services/api_service.dart';

class FoodProvider extends ChangeNotifier {
  List<Food> foods = [];

  Future<void> fetchFoods() async {
    final data = await ApiService.getFoods();
    foods = data.map<Food>((e) => Food.fromJson(e)).toList();
    notifyListeners();
  }
}
