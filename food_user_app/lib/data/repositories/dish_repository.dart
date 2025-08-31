import '../services/dishes/dish_api_service.dart';
import '../models/dish.dart';
import '../../core/responses/result.dart';
import '../../core/models/failure.dart';

class DishRepository {
  final DishApiService dishApiService;

  DishRepository({required this.dishApiService});

  Future<Result<List<Dish>>> getDishes() async {
    try {
      // Try to get dishes from API first
      final dishes = await dishApiService.getDishes();

      return Result.success(dishes);
    } catch (e) {
      return Result.failure(
        NetworkFailure('Failed to get dishes: ${e.toString()}'),
      );
    }
  }
}
