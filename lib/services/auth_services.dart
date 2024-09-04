import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  AuthServices._();

  static AuthServices authServices = AuthServices._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign Up
  Future<void> createAccountWithEmailAndPassword(String email,
      String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Sign In
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try
    {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
      return 'Success';
    }catch(e)
    {
      return e.toString();
    }
  }

  //Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //todo get Current User Info
  User? getCurrentUser()
  {
    User? user = _firebaseAuth.currentUser;
    if(user!=null)
      {
        log("email : ${user.email}");
      }
    return user;
  }
}