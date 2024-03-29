import 'dart:developer';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:projecture_admin/auth/admin_login_screen.dart';
import 'package:projecture_admin/service/animayted_text.dart';
import 'package:projecture_admin/service/wavy_text.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'admin_bottombar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  String? uid;

  setData() async {
    final pref = await SharedPreferences.getInstance();
    uid = pref.getString("userId");
    log("""
    
   userid       ${pref.getString("userId")};
    company id -- ${pref.getString("companyId")};
    """);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logo.png',
                color: ColorUtils.primaryColor,
                height: 10.w,
                width: 15.w,
              ),
              AnimatedCustomeTextKit(
                animatedTexts: [
                  WavyAnimatedText(" P r o j e c t u r e ",
                      textStyle: FontTextStyle.Proxima16Medium.copyWith(
                          fontWeight: FontWeightClass.extraB,
                          fontSize: 20.sp,
                          color: ColorUtils.primaryColor),
                      speed: const Duration(milliseconds: 210)),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
            ],
          ),
          duration: 4000,
          splashTransition: SplashTransition.sizeTransition,
          backgroundColor: ColorUtils.white,
          nextScreen: uid != null ? BottomNavBarScreen() : AdminLoginScreen(),
        ));
  }
}
