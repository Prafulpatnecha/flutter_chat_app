import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/modal/user_model.dart';
import 'package:flutter_chat_app/services/auth_services.dart';
import 'package:flutter_chat_app/services/firebase_cloud_services.dart';
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
                  backgroundColor:
                      WidgetStateProperty.all(Colors.black.withOpacity(0.2))),
              onPressed: () async {
                await AuthServices.authServices.signOut();
                await GoogleAuthService.googleAuthService.signOutFromGoogle();
                User? user = AuthServices.authServices.getCurrentUser();

                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: const Icon(Icons.login_outlined)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: CloudFirebaseStoreServices.cloudFirebaseStoreServices
              .readCurrentUserFromFireStore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            Map? data = snapshot.data!.data();
            UserModel userModel = UserModel.fromUser(data!);
            return Column(
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userModel.image),
                  ),
                ),
                Text(userModel.email),
                Text(userModel.phone),
              ],
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: CloudFirebaseStoreServices.cloudFirebaseStoreServices
            .readAllUserFromFireStore(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List data = snapshot.data!.docs;
          List<UserModel> userList = [];
          for (var user in data) {
            userList.add(
              UserModel.fromUser(
                user.data(),
              ),
            );
          }
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(userList[index].image),),
                title: Text(userList[index].name),
                subtitle: Text(userList[index].email),
              );
          },);
        },
      ),
    );
  }
}
