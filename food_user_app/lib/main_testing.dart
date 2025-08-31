import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/data/repositories/dish_repository.dart';
import 'package:food_app/data/services/dishes/dish_api_service.dart';
import 'package:food_app/data/services/dishes/dish_local_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // الآن FirebaseAuth.instance سيكون جاهز بعد التهيئة 👇
  final Dishrepository = DishRepository(dishApiService: DishApiService());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text('test'),
            onPressed: () async {
              final result = await Dishrepository.getDishes();
              print(result.data!.first.name);
              try {} catch (e) {
                print(' error: $e');
              }
            },
          ),
        ),
      ),
    );
  }
}
