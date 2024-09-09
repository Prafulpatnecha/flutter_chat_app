import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/auth_manager.dart';
import '../auth/sign_in.dart';
import '../auth/sign_up.dart';
import '../home/home_page.dart';


class MyChat extends StatelessWidget {
  const MyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const AuthManager(),transition: Transition.circularReveal),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/signUp', page: () => const SignUpPage(),transition: Transition.fadeIn),
        GetPage(name: '/signIn', page: () => const SignInPage(),transition: Transition.fade),
      ],
    );
  }
}
