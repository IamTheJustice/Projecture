import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:projecture_admin/auth/admin_registration_screen.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:sizer/sizer.dart';

import '../admin_BottomBar_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool isCheckPassword = true;
  final formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorUtils.white,
        body: Form(
          key: formkey,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/background.png"),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/logo.png',
                          color: ColorUtils.white,
                          height: 9.w,
                          width: 12.w,
                        ),
                        Text(
                          "Projecture",
                          style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeightClass.extraB),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 45.w),
                    child: Container(
                      height: 20.w,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(90.0))),
                      child: Center(
                        child: Text(
                          "Welcome Back",
                          style: FontTextStyle.Proxima16Medium.copyWith(
                              fontSize: 18.sp,
                              color: ColorUtils.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 11.w),
                child: TextFormField(
                  controller: emailController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "please email required";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(v)) {
                      return "please enter valid email ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(4.w),
                      filled: true,
                      fillColor: ColorUtils.greyE7.withOpacity(0.5),
                      hintText: "Email/Username",
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        size: 5.w,
                      ),
                      hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                          color: ColorUtils.primaryColor),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.w),
                child: TextFormField(
                  controller: passwordController,
                  validator: (v) {
                    // add your custom validation here.
                    if (v!.isEmpty) {
                      return 'Please enter password';
                    }
                    if (v.length <= 8) {
                      return 'Password must be atleast 8 characters long';
                    }
                  },
                  obscureText: isCheckPassword,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(4.w),
                      filled: true,
                      fillColor: ColorUtils.greyE7.withOpacity(0.5),
                      hintText: "Password",
                      suffixIcon: InkWell(
                        onTap: () {
                          isCheckPassword = !isCheckPassword;
                          setState(() {});
                        },
                        child: Icon(isCheckPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                          color: ColorUtils.primaryColor),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: TextButton(
                    onPressed: () {
                      // Get.to(() => const ForgotPasswordScreen());
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot Password?",
                        style: FontTextStyle.Proxima10Regular.copyWith(
                            color: ColorUtils.grey79,
                            fontWeight: FontWeightClass.semiB),
                      ),
                    )),
              ),
              SizeConfig.sH3,
              AnimatedButton(
                  height: 12.w,
                  width: 60.w,
                  text: "LOGIN",
                  textStyle: FontTextStyle.Proxima14Regular.copyWith(
                      fontSize: 12.sp, color: ColorUtils.white),
                  borderRadius: 10.0,
                  backgroundColor: ColorUtils.primaryColor,
                  selectedBackgroundColor: ColorUtils.purple,
                  transitionType: TransitionType.CENTER_ROUNDER,
                  selectedTextColor: ColorUtils.white,
                  isReverse: true,
                  onPress: () async {
                    FocusScope.of(context).requestFocus();
                    if (formkey.currentState!.validate()) {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                      Get.showSnackbar(
                        GetSnackBar(
                          message: "Login Succesfully",
                          borderRadius: 10.0,
                          margin: EdgeInsets.only(
                              left: 4.w, right: 4.w, bottom: 4.w),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: ColorUtils.primaryColor,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(
                        Duration(seconds: 3),
                        () {
                          Get.to(() => const BottomNavBarScreen());
                        },
                      );
                    }
                  }),
              SizeConfig.sH2,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account ?",
                    style: FontTextStyle.Proxima10Regular.copyWith(
                        color: ColorUtils.primaryColor,
                        fontWeight: FontWeightClass.semiB),
                  ),
                  TextButton(
                      onPressed: () {
                        // Get.to(() => RegisterScreen());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AdminRegisterScreen()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor,
                            fontWeight: FontWeightClass.semiB),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
