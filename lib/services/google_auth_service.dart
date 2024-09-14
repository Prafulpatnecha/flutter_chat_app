import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService._();

  static GoogleAuthService googleAuthService = GoogleAuthService._();

  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication authentication =
          await googleSignInAccount!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      log(userCredential.user!.email!);
      log(userCredential.user!.photoURL!);
    } catch (e) {
      Get.snackbar("Google Sign Failed!", e.toString());
      log(e.toString());
    }
  }

  Future<void> signOutFromGoogle() async {
    await googleSignIn.signOut();
  }
}
