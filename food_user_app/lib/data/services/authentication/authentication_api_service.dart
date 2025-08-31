import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication_service.dart';

class AuthenticationApiService implements AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;

        return {...data, 'uid': userCredential.user!.uid};
      } else {
        return Future.error('User data not found in Firestore');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return Future.error('Wrong password provided for that user.');
      }
      return Future.error(e.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create user document in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        // Add other default user data here
      });

      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();
      return userDoc.data()!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('The account already exists for that email.');
      }
      return Future.error(e.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<bool> setPosition({
    required String uid,
    required double xPosition,
    required double yPosition,
  }) async {
    try {
      // Update user position directly using uid
      await _firestore.collection('users').doc(uid).update({
        'x_position': xPosition,
        'y_position': yPosition,
      });
      return true; // Return success
    } catch (e) {
      return false; // Return failure
    }
  }
}
