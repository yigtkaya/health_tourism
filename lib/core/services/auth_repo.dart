import '../../product/models/user.dart';

abstract class AuthRepository {
  IUser getCurrentUser();
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signUpWithEmailAndPassword({required String email, required String password});
  Future<void> logout();
  Future<void> resetPassword({required String email});
  Future<bool> isUserLoggedIn();
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<bool> isFirstRun();
  Future<void> updateUserData(
      String firstname, String lastName, String birthday);
}