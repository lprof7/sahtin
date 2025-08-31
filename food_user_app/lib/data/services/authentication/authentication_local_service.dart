import 'authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/user.dart';
import 'dart:convert';

class AuthenticationLocalService implements AuthenticationService {
  static const String _userKey = 'user';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) {
      return null;
    }
    return User.fromJson(jsonDecode(userJson));
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
  }

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    // Check if user exists locally
    final user = await getUser();
    if (user != null) {
      return user.toJson();
    }
    return {};
  }

  @override
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
  }) async {
    return {};
  }

  @override
  Future<bool> setPosition({
    required String uid,
    required double xPosition,
    required double yPosition,
  }) async {
    return false;
  }
}
