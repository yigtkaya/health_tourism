import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/repoImpl/auth_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../product/navigation/route_paths.dart';
import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();
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

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      emit(const AuthLoading());
      await _authRepository.signInWithEmailAndPassword(
          email: email, password: password);
      if (firebaseAuth.currentUser != null) {
        emit(Authenticated(firebaseAuth.currentUser!));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // create function to sign up with email and password
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      emit(const AuthLoading());
      await _authRepository.signUpWithEmailAndPassword(
          email: email, password: password);
      emit(const AuthUserCreated());
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
      Future.delayed(const Duration(seconds: 2), () {
        goTo(path: RoutePath.bottomNavigation);
      });
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // create a function to login with facebook
  Future<void> signInWithFacebook() async {
    try {
      emit(const AuthLoading());
      await _authRepository.signInWithFacebook();
      emit(Authenticated(firebaseAuth.currentUser!));
      Future.delayed(const Duration(seconds: 2), () {
        goTo(path: RoutePath.bottomNavigation);
      });
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // create a function to get user id
  String? getCurrentUserId() {
    return _authRepository.getCurrentUserId();
  }

  // create a function to sign out
  Future<void> signOut() async {
    try {
      emit(const AuthLoading());
      await _authRepository.logout();
      emit(const NotAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<bool> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onBoard') ?? false;
  }
}
