import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/authentication/authentication_api_service.dart';
import '../../data/services/authentication/authentication_local_service.dart';
import '../../data/services/dishes/dish_api_service.dart';
import '../../presentation/features/auth/viewmodel/login_cubit.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/repositories/dish_repository.dart';
import '../../data/models/dish.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(DishAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(RatingAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(OptionAdapter());
  }

  // Open Hive boxes
  await Hive.openBox('dishes');

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register services
  sl.registerLazySingleton<AuthenticationApiService>(
    () => AuthenticationApiService(),
  );

  sl.registerLazySingleton<AuthenticationLocalService>(
    () => AuthenticationLocalService(),
  );

  sl.registerLazySingleton<DishApiService>(() => DishApiService());

  // Register repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepository(
      authenticationApiService: sl<AuthenticationApiService>(),
      authenticationLocalService: sl<AuthenticationLocalService>(),
    ),
  );

  sl.registerLazySingleton<DishRepository>(
    () => DishRepository(dishApiService: sl<DishApiService>()),
  );

  // Register view models
  sl.registerFactory(
    () => LoginCubit(authenticationRepository: sl<AuthenticationRepository>()),
  );
}
