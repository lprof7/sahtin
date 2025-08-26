import 'authentication_service.dart';

class AuthenticationLocalService implements AuthenticationService {
  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return {};
  }

  @override
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
  }) async {
    return {};
  }
}
