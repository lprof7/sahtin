import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/features/auth/view/login_screen.dart';
import '../../presentation/features/auth/viewmodel/login_cubit.dart';
import '../../presentation/features/set_position/view/set_position_screen.dart';
// import '../../presentation/features/browse/view/browse_screen.dart';
import '../dependency_injection/service_locator.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String setPositionRoute = '/set-position';
  static const String homeRoute = '/home';
  static const String browseRoute = '/browse';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => sl<LoginCubit>(),
                child: const LoginScreen(),
              ),
        );

      case setPositionRoute:
        return MaterialPageRoute(builder: (_) => const SetPositionScreen());

      case homeRoute:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                appBar: AppBar(
                  title: const Text('صحتين'),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                body: const Center(
                  child: Text(
                    'مرحباً بك في تطبيق صحتين!',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
        );
      //case browseRoute:
      //  return MaterialPageRoute(builder: (_) => const BrowseScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('الصفحة غير موجودة: ${settings.name}'),
                ),
              ),
        );
    }
  }
}
