import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/dish.dart';
import 'dish_service.dart';

class DishApiService implements DishService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Dish>> getDishes() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('dishes').get();

      final List<Dish> dishes =
          querySnapshot.docs.map((doc) {
            final Map<String, dynamic> data = Map<String, dynamic>.from(
              doc.data() as Map<String, dynamic>,
            );
            if (data['uid'] == null) {
              data['uid'] = doc.id;
            }
            return Dish.fromJson(data);
          }).toList();

      return dishes;
    } catch (e, st) {
      print('Failed to get dishes: $e\n$st');
      throw Exception('Failed to get dishes: ${e.toString()}');
    }
  }
}
