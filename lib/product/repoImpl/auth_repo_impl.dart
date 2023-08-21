import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/repositories/auth_repo.dart';
import 'package:twitter_login/twitter_login.dart';
import '../../cubit/auth/auth_exception_handler.dart';
import '../navigation/route_paths.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  @override
  String? getCurrentUserId() {
    // get current user from firebase auth
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Future<bool> isUserLoggedIn() {
    // check if user is logged in
    return Future.value(_firebaseAuth.currentUser != null);
  }

  @override
  Future<void> logout() async {
    // sign out from firebase auth and google or facebook
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await _facebookAuth.logOut();

    goTo(path: RoutePath.signIn);
  }

  @override
  Future<void> resetPassword({required String email}) async {
    // send reset password email
    if (email.isEmpty) {
      showToastMessage("Email cannot be empty. Please enter your email to reset your password.");
      return;
    }

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      showToastMessage(
          "Reset password email sent succesfully please check your mail.");
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage("Failed to send reset password email.");
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    // sign in with email and password
    if (email.isEmpty || password.isEmpty) {
      showToastMessage("Password or email cannot be empty.");
      return;
    }
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((authUser) {
        authUser.user!.reload();

        if (!authUser.user!.emailVerified) {
          authUser.user!.sendEmailVerification();
        }

        goTo(path: RoutePath.bottomNavigation);
      });
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage("An error occurred. Failed to sign in.");
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    try {
      final facebookLoginResult =
          await _facebookAuth.login(permissions: ['public_profile', 'email']);
      final userData = await FacebookAuth.instance.getUserData();

      final AuthCredential credential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage("An error occurred. Failed to sign in.");
    }
  }

  @override
  Future<void> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
        apiKey: "D38vH6YDecit8Qmbo2ccEB7BY",
        apiSecretKey: "h9KWLTZ6QMSrOJTxlrQfO3ndjOtDhChFrqG9lcN88gmD1mNiTa",
        redirectURI: "https://health-tourism-cc878.firebaseapp.com/__/auth/handler");

    final authResult = await twitterLogin.login();

    if (authResult.status == TwitterLoginStatus.loggedIn) {
      final AuthCredential credential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken!,
          secret: authResult.authTokenSecret!);

      await _firebaseAuth.signInWithCredential(credential);

    } else if (authResult.status == TwitterLoginStatus.cancelledByUser) {
      showToastMessage("Login cancelled by user");
    } else if (authResult.status == TwitterLoginStatus.error) {
      showToastMessage("Login error: ${authResult.errorMessage}");
    } else {
      showToastMessage("Login error: ${authResult.errorMessage}");
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage("An error occurred. Failed to sign in.");
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    // sign up with email and password
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((authUser) {
            authUser.user?.sendEmailVerification();
            _firebaseAuth.signOut();
          })
          .then((value) {
            showToastMessage(
              "We have send you a verification email to verify your account");
          });
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage("An error occurred. Failed to sign up.");
    }
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xFF58A2EB),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
