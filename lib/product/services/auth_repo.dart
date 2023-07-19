import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/product/models/clinics-entity.dart';

abstract class AuthRepository {
  User getCurrentUser();
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {}
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signUpWithEmailAndPassword({required String email, required String password}) async {}
  Future<void> resetPassword({required String email}) async {}
  Future<bool> isUserLoggedIn();
  Future<void> logout();
  Future<void> updateUserData(
      String firstname, String lastName, String birthday);
}