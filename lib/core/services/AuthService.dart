import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (e) {
      /// TO DO: Handle error strings in a better way
      print(e);
    }
  }
  Future<void> signUp(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      /// TO DO: Handle error strings in a better way
      print(e);
    }
  }
  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      /// TO DO: Handle error strings in a better way
      print(e);
    }
  }
  // Define a function that checks if the user is logged in with stream listening to the authStateChanges
}