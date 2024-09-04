import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth_services.dart';
import 'package:flutter_chat_app/view/auth/sign_in.dart';
import 'package:flutter_chat_app/view/home/home_page.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthServices.authServices.getCurrentUser() == null
        ? const SignInPage()
        : const HomePage();
  }
}
