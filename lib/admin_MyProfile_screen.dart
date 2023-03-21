import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecture_admin/auth/admin_login_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () {
              Get.to(() => AdminLoginScreen());
            },
            child: Text("Logout")),
      ),
    );
  }
}
