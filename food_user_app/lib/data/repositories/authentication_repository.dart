import '../services/authentication/authentication_service.dart';
import '../services/authentication/authentication_local_service.dart';
import '../models/user.dart';
import '../../core/responses/result.dart'; // Import Result
import '../../core/models/failure.dart';

class AuthenticationRepository {
  final AuthenticationService authenticationApiService;
  final AuthenticationLocalService authenticationLocalService;

  AuthenticationRepository({
    required this.authenticationApiService,
    required this.authenticationLocalService,
  });

  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    // Return Result<User>
    try {
      // call API service
      final Map<String, dynamic> jsonResponse = await authenticationApiService
          .login(email: email, password: password);
      final user = User.fromJson(jsonResponse);
      // Save user locally
      await authenticationLocalService.saveUser(user);

      return Result.success(user); // Return Success
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString())); // Return Failure
    }
  }

  Future<User> signup({required String email, required String password}) async {
    try {
      final Map<String, dynamic> jsonResponse = await authenticationApiService
          .signup(email: email, password: password);
      final user = User.fromJson(jsonResponse); // Convert JSON to User object

      // Save user locally
      await authenticationLocalService.saveUser(user);

      return user;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Result<bool>> setPosition({
    required String uid,
    required double xPosition,
    required double yPosition,
  }) async {
    try {
      final bool success = await authenticationApiService.setPosition(
        uid: uid,
        xPosition: xPosition,
        yPosition: yPosition,
      );
      return Result.success(success); // Return Success
    } catch (e) {
      return Result.failure(UnknownFailure(e.toString())); // Return Failure
    }
  }
}
