import 'package:health_tourism/core/services/auth_repo.dart';

import '../../product/models/user.dart';

class FirebaseAuthService extends AuthRepository {
/// TO DO: Implement FirebaseAuthException
  @override
  User currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isFirstRun() {
    // TODO: implement isFirstRun
    throw UnimplementedError();
  }

  @override
  Future<void> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> passwordResetSubmit(String email) {
    // TODO: implement passwordResetSubmit
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserData(String firstname, String lastName, String birthday) {
    // TODO: implement updatePersonalData
    throw UnimplementedError();
  }
}