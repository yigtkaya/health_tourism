import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/core/services/firebase_auth_service.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService _authRepository = FirebaseAuthService();
  final firebaseAuth = FirebaseAuth.instance;

  AuthCubit() : super(const AuthInitial());

  @override
  List<Object> get props => [];

  void updateEmail(String email) {
    emit(AuthEmailUpdated(email));
  }

  void updatePassword(String password) {
    emit(AuthPasswordUpdated(password));
  }
  void updatePasswordConfirm(String passwordSec) {
    emit(AuthPasswordConfirmUpdated(passwordSec));
  }
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

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      email = (state as AuthEmailUpdated).email;
      password = (state as AuthPasswordUpdated).password;
  print(email + password + "email and password");
      emit(const AuthLoading());
      await _authRepository.signInWithEmailAndPassword(email: email, password: password);
      emit(Authenticated(firebaseAuth.currentUser!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // create function to sign up with email and password
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      emit(const AuthLoading());
      await _authRepository.signUpWithEmailAndPassword(email: email, password: password);
      final currentUser = _authRepository.getCurrentUser();
      emit(Authenticated(currentUser));
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
      goTo(path: RoutePath.landing);
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

  bool isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

 // create a function to login with facebook
  Future<void> signInWithFacebook() async {
    try {
      emit(const AuthLoading());
      await _authRepository.signInWithFacebook();
      emit(Authenticated(firebaseAuth.currentUser!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }


}