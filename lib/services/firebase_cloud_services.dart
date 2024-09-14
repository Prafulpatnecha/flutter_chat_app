import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/modal/user_model.dart';
import 'package:flutter_chat_app/services/auth_services.dart';

class CloudFirebaseStoreServices {
  CloudFirebaseStoreServices._();

  static CloudFirebaseStoreServices cloudFirebaseStoreServices =
      CloudFirebaseStoreServices._();

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel userModel) async {
    await firebaseFireStore.collection("users").doc(userModel.email).set({
      'email': userModel.email,
      'name': userModel.name,
      'image': userModel.image,
      'token': userModel.token,
      'phone': userModel.phone
    });
  }

  //todo Read data for current user
  Future<DocumentSnapshot<Map<String, dynamic>>>
      readCurrentUserFromFireStore() async {
    User? user = AuthServices.authServices.getCurrentUser();
    return await firebaseFireStore.collection("users").doc(user!.email).get();
  }

  //todo read all user data
  Future<QuerySnapshot<Map<String, dynamic>>> readAllUserFromFireStore() async {
    User? user=AuthServices.authServices.getCurrentUser();
    return await firebaseFireStore.collection("users").where("email",isNotEqualTo: user!.email).get();
  }
}
