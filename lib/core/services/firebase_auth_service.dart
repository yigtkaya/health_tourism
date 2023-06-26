// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_tourism/core/services/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cubit/auth/auth_exception_handler.dart';
import '../../product/models/user.dart';

class FirebaseAuthService extends AuthRepository {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _firestore = FirebaseFirestore.instance.collection("users");


  @override
  IUser currentUser() {
    // create IUser object
    return IUser(uid: _firebaseAuth.currentUser!.uid, email: _firebaseAuth.currentUser!.email!);
  }

  @override
  Future<bool> isFirstRun() {
    // check if user id is in exist in firestore if yes then return true else add user id to firestore
    _firestore.doc(_firebaseAuth.currentUser!.uid).get().then((doc) {
      if (doc.exists) {
        return true;
      } else {
        _firestore.doc(_firebaseAuth.currentUser!.uid).set({"uid": _firebaseAuth.currentUser!.uid});
        return false;
      }
    });
    return Future.value(false);
  }

  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((authUser) {
        authUser.user?.reload();

        if (authUser.user!.emailVerified) {
        } else {
          authUser.user!.sendEmailVerification();
        }
      });

    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      // TO DO show error message
    } catch (e) {
      // TO DO show error message
    }
  }

  @override
  Future<void> logout() async {
    // sign out from firebase auth
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      // TO DO show error message
    } catch (e) {
      // TO DO show error message
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({required String email, required String password}) async {
  try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((authUser) => authUser.user?.sendEmailVerification());
    } on FirebaseAuthException catch (e) {
      final message = AuthExceptionHandler.generateExceptionMessage(e.code);
      // TO DO show error message
    } catch (e) {
      // TO DO show error message
    }
  }

  @override
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
      // TO DO show error message
    } catch (e) {
      // TO DO show error message
    }
  }

  @override
  Future<void> updateUserData(String firstname, String lastName, String birthday) async {


  }
}