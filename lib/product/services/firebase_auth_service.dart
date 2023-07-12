import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cubit/auth/auth_exception_handler.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  User getCurrentUser() {
    // get current user from firebase auth
    return _firebaseAuth.currentUser!;
  }
  String? getCurrentUserId() {
    // get current user from firebase auth
    return _firebaseAuth.currentUser?.uid;
  }

  Future<bool> isUserLoggedIn() {
    // check if user is logged in
    return Future.value(_firebaseAuth.currentUser != null);
  }

  Future<void> logout() async {
    // sign out from firebase auth and google or facebook
    await _firebaseAuth.signOut();
    await _facebookAuth.logOut();
  }

  Future<void> resetPassword({required String email}) async {
    // send reset password email
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    // sign in with email and password
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password).then((authUser) {
        authUser.user!.reload();

        if (!authUser.user!.emailVerified) {
          authUser.user!.sendEmailVerification();
        }
      });
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final facebookLoginResult = await _facebookAuth.login(permissions: ['public_profile', 'email']);
      final userData = await FacebookAuth.instance.getUserData();

      final AuthCredential credential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);

      await _firebaseAuth.signInWithCredential(credential);

    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  Future<void> signUpWithEmailAndPassword({required String email, required String password}) async {
    // sign up with email and password
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((authUser) => authUser.user?.sendEmailVerification())
          .then((value) => showToastMessage(
          "We have send you a verification email to verify your account"));

    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      showToastMessage(message);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  Future<void> updateUserData(String firstname, String lastName, String birthday) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }


  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
