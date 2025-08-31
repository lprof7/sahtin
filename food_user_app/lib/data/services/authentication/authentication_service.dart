abstract class AuthenticationService {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
  });
  Future<bool> setPosition({
    required String uid,
    required double xPosition,
    required double yPosition,
  });
}
