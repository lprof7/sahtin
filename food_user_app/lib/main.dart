import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/message_lookup_by_library.dart';

import 'core/dependency_injection/service_locator.dart';
import 'core/routing/app_router.dart';
import 'presentation/shared/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize dependency injection
  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صحتين',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      //onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.loginRoute, // Start with login screen
    );
  }
}
