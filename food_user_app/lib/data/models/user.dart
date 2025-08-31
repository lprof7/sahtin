import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String uid;

  const User({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      uid: json['uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'uid': uid,
    };
  }

  @override
  List<Object?> get props => [firstName, lastName, phone, email, uid];
}
