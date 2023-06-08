import '../../product/models/user.dart';

abstract class AuthRepository {
  User currentUser();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  Future<void> passwordResetSubmit(String email);
  Future<void> signInWithGoogle();
  Future<bool> isFirstRun();
  Future<void> updatePersonalData(
      String firstname, String lastName, String birthday);
}