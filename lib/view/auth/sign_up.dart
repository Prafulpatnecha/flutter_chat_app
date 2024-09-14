import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/modal/user_model.dart';
import 'package:flutter_chat_app/services/firebase_cloud_services.dart';
import 'package:get/get.dart';

import '../../services/auth_services.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        centerTitle: true,
        title: const Text("Sign Up"),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: authController.textName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Name",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: authController.textPhoneNo,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Phone No.",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: authController.textEmail,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Create Your Email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: authController.textPassword,
                  decoration: const InputDecoration(
                    hintText: "Create Password",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: authController.textConfirmPassword,
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                          authController.textPassword.clear();
                          authController.textEmail.clear();
                        },
                        child: const Text(
                          "Don't have account? Sign In",
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      WidgetStateProperty.all(Colors.blue.shade50)),
                  onPressed: () async {
                    if(authController.textPassword.text.toString()==authController.textConfirmPassword.text.toString())
                      {
                        await AuthServices.authServices.createAccountWithEmailAndPassword(authController.textEmail.text, authController.textPassword.text);
                        UserModel userModel = UserModel(name: authController.textName.text, email: authController.textEmail.text, image: "", phone: authController.textPhoneNo.text, token: '');

                        CloudFirebaseStoreServices.cloudFirebaseStoreServices.insertUserIntoFireStore(userModel);

                        authController.textPassword.clear();
                        authController.textEmail.clear();
                        authController.textPhoneNo.clear();
                        authController.textName.clear();
                        authController.textConfirmPassword.clear();
                        Get.back();
                      }
                    else{
                      const GetSnackBar(title: "Entered Password Failed!!",);
                    }
                  },
                  child: const Text("Sign Up? Your new account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
