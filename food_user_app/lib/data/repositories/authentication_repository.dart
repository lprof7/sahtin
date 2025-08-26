import '../services/authentication/authentication_service.dart';
import '../models/user.dart'; // Import the User model

class AuthenticationRepository {
  final AuthenticationService authenticationService;

  AuthenticationRepository({required this.authenticationService});

  Future<User> login({required String email, required String password}) async {
    try {
      final Map<String, dynamic> jsonResponse = await authenticationService
          .login(email: email, password: password);
      return User.fromJson(jsonResponse); // Convert JSON to User object
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<User> signup({required String email, required String password}) async {
    try {
      final Map<String, dynamic> jsonResponse = await authenticationService
          .signup(email: email, password: password);
      return User.fromJson(jsonResponse); // Convert JSON to User object
    } catch (e) {
      return Future.error(e);
    }
  }
}
