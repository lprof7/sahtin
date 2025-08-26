import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/data/repositories/authentication_repository.dart';
import 'package:food_app/data/services/authentication/authentication_api_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // الآن FirebaseAuth.instance سيكون جاهز بعد التهيئة 👇
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
        authenticationService: AuthenticationApiService(),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text('test'),
            onPressed: () async {
              try {
                final result = await authenticationRepository.login(
                  email: "test@gmail.com",
                  password: "aaaaaa",
                );
                print('Login result: $result');
              } catch (e) {
                print('Login error: $e');
              }
            },
          ),
        ),
      ),
    );
  }
}
