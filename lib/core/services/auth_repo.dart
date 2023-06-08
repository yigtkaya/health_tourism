import '../../product/models/user.dart';

abstract class AuthRepository {
  User currentUser();
  Future<void> login(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> logout();
  Future<void> passwordResetSubmit(String email);
  Future<void> signInWithGoogle();
  Future<bool> isFirstRun();
  Future<void> updateUserData(
      String firstname, String lastName, String birthday);
}