import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/core/services/firebase_auth_service.dart';
import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService _authRepository = FirebaseAuthService();
  final firebaseAuth = FirebaseAuth.instance;

  AuthCubit() : super(const AuthInitial());

  @override
  List<Object> get props => [];

  // check if user is logged in
  Future<void> checkIfUserIsLoggedIn() async {
    try {
      emit(const AuthLoading());
      final isUserLoggedIn = await _authRepository.isUserLoggedIn();
      if (isUserLoggedIn) {
        emit(Authenticated(firebaseAuth.currentUser!));
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
      await _authRepository.signInWithEmailAndPassword(email: email, password: password);
      emit(Authenticated(firebaseAuth.currentUser!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      emit(const AuthLoading());
      await _authRepository.signUpWithEmailAndPassword(email: email, password: password);
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
      await _authRepository.resetPassword(email: email);
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