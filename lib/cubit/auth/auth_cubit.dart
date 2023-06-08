import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/services/auth_repo.dart';
import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final firebaseAuth = FirebaseAuth.instance;

  AuthCubit(this._authRepository) : super(const AuthInitial());

  Future<void> checkFirstRun() async {
    try {
      final isFirstRun = await _authRepository.isFirstRun();
      if (isFirstRun) {
        emit(const FirstRun());
      } else {
        emit(const NotAuthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(const AuthLoading());
      await _authRepository.login(email, password);
      emit(Authenticated(firebaseAuth.currentUser!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      emit(const AuthLoading());
      await _authRepository.signUp(email, password);
      emit(Authenticated(firebaseAuth.currentUser!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(const AuthLoading());
      await _authRepository.logout();
      emit(const NotAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> passwordResetSubmit(String email) async {
    try {
      emit(const AuthLoading());
      await _authRepository.passwordResetSubmit(email);
      emit(const PasswordRequestSubmitted());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const AuthLoading());
      await _authRepository.signInWithGoogle();
      emit(Authenticated(firebaseAuth.currentUser!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> updateUserData(String firstname, String lastName, String birthday) async {
    try {
      emit(const AuthLoading());
      await _authRepository.updateUserData(firstname, lastName, birthday);
      emit(const PersonalDataUpdated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}