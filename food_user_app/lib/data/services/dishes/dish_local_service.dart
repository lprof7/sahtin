import 'package:food_app/data/models/dish.dart';
import 'package:food_app/data/services/dishes/dish_api_service.dart';
import 'package:food_app/data/services/dishes/dish_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DishLocalService implements DishService {
  static const String _dishesKey = 'dishes';

  @override
  Future<List<Dish>> getDishes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? dishesJson = prefs.getStringList(_dishesKey);
    if (dishesJson == null) {
      throw Exception('Dishes not found');
    }
    return dishesJson.map((json) => Dish.fromJson(jsonDecode(json))).toList();
  }

  // Add other Dish-related local methods here
}
