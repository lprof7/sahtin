import '../../models/dish.dart';

abstract class DishService {
  Future<List<Dish>> getDishes();
}
