import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/auth_controller.dart';
import 'package:flutter_chat_app/services/auth_services.dart';
import 'package:flutter_chat_app/services/google_auth_service.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        centerTitle: true,
        title: const Text("Sign In"),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: authController.textEmail,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "Enter Your Email",
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
                  hintText: "Enter Your Password",
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
                        Get.toNamed("/signUp");
                      },
                      child: const Text(
                        "Don't have account? Sign Up",
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
                  String response=await AuthServices.authServices.signInWithEmailAndPassword(
                      authController.textEmail.text,
                      authController.textPassword.text);
                  User? user = AuthServices.authServices.getCurrentUser();
                  if(user!=null && response == "Success")
                    {
                      Get.offAndToNamed("/home");
                    }else{
                    Get.snackbar("Sign In Failed !", response);
                  }
                },
                child: const Text("Sign In"),
              ),
              SignInButton(
                  Buttons.google,
                  onPressed: () async {
                await GoogleAuthService.googleAuthService.signInWithGoogle();
                User? user = AuthServices.authServices.getCurrentUser();
                if(user!=null)
                {
                  Get.offAndToNamed("/home");
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

