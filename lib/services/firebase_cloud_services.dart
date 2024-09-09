


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/modal/user_model.dart';

class CloudFirebaseStoreServices {
  CloudFirebaseStoreServices._();
  static CloudFirebaseStoreServices cloudFirebaseStoreServices = CloudFirebaseStoreServices._();

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel userModel)
  async {
    await firebaseFireStore.collection("users").doc(userModel.email).set({
      'email': userModel.email,
      'name': userModel.name,
      'image': userModel.image,
      'token': userModel.token,
      'phone': userModel.phone
    });
  }
}