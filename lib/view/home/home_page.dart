import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth_services.dart';
import 'package:flutter_chat_app/services/google_auth_service.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black.withOpacity(0.2))
              ),
              onPressed: () async {
            await AuthServices.authServices.signOut();
            await GoogleAuthService.googleAuthService.signOutFromGoogle();
            User? user = AuthServices.authServices.getCurrentUser();

            if(user==null)
              {
                Get.offAndToNamed('/signIn');
              }
          }, icon: const Icon(Icons.login_outlined)),
          const SizedBox(width: 10,)
        ],
      ),
      body: Container(
        
      ),
    );
  }
}
