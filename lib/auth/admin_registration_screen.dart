import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:projecture_admin/auth/admin_login_screen.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';

import 'package:sizer/sizer.dart';

class AdminRegisterScreen extends StatefulWidget {
  const AdminRegisterScreen({Key? key}) : super(key: key);

  @override
  State<AdminRegisterScreen> createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController companynameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> list1 = <Map<String, dynamic>>[
    {
      "imagepath": "assets/icons/android.png",
      "title": 'Android',
      "isSelect": false
    },
    {"imagepath": "assets/icons/node.png", "title": 'Node', "isSelect": false},
    {
      "imagepath": "assets/icons/flutter.png",
      "title": 'Flutter',
      "isSelect": false
    },
    {"imagepath": "assets/icons/ios.png", "title": 'IOS', "isSelect": false},
    {"imagepath": "assets/icons/php.png", "title": 'PHP', "isSelect": false},
    {
      "imagepath": "assets/icons/react.png",
      "title": 'React',
      "isSelect": false
    },
  ];

  DateTime date = DateTime.now();
  late var formattedDate = "Start Date";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: ColorUtils.white,
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Register",
                              style: FontTextStyle.Proxima16Medium.copyWith(
                                  fontSize: 18.sp,
                                  color: ColorUtils.primaryColor,
                                  fontWeight: FontWeightClass.semiB),
                            ),
                            Text(
                              "create your account",
                              style: FontTextStyle.Proxima14Regular.copyWith(
                                  color: ColorUtils.primaryColor,
                                  fontWeight: FontWeightClass.semiB),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                  child: TextFormField(
                    controller: fullnameController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "please name required";
                      } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(v)) {
                        return "please valid name ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Full Name",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                  child: TextFormField(
                    controller: addressController,
                    maxLines: 2,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "please address required";
                      } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(v)) {
                        return "please valid address ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Address",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                  child: TextFormField(
                    controller: companynameController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "please company name required";
                      } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(v)) {
                        return "please valid company name ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Company Name",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
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
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                  child: TextFormField(
                    controller: dateController,
                    readOnly: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "please required date";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "${formattedDate}",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    onTap: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2030),
                      ).then((selectedDate) {
                        // if (selectedDate != null) {
                        //   setState(() {
                        //     date = selectedDate;
                        //     formattedDate =
                        //         DateFormat('d-MMM-yy').format(selectedDate);
                        //   });
                        // }
                        if (selectedDate != null) {
                          formattedDate =
                              DateFormat('d-MMM-yy').format(selectedDate);
                          setState(() {
                            dateController.text = formattedDate;
                          });
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
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
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Password",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    validator: (v) {
                      if (v!.isEmpty) return 'Empty';
                      if (v != passwordController.text) return 'Not Match';
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Confirm Password",
                        hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                            color: ColorUtils.primaryColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                SizeConfig.sH1,
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    "Language :",
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: ColorUtils.primaryColor,
                        fontWeight: FontWeightClass.semiB),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.w, right: 6.w, left: 6.w),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 6.0,
                    children: List.generate(
                        list1.length,
                        (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.w, horizontal: 0.8.w),
                            child: InkWell(
                              onTap: () {
                                log("Index===$index");
                                list1[index]['isSelect'] =
                                    !list1[index]['isSelect'];
                                setState(() {});
                                log('selectionList${list1[index]}');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: list1[index]['isSelect']
                                        ? ColorUtils.primaryColor
                                        : ColorUtils.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                        color: ColorUtils.primaryColor)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 2.w,
                                      right: 2.w,
                                      top: 0.5.h,
                                      bottom: 0.5.h),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        list1[index]['imagepath'],
                                        scale: 2.w,
                                      ),
                                      SizeConfig.sW1,
                                      Text(
                                        list1[index]['title'],
                                        style: FontTextStyle.Proxima14Regular
                                            .copyWith(
                                          color: list1[index]['isSelect']
                                              ? ColorUtils.white
                                              : ColorUtils.primaryColor,
                                        ),
                                      ),
                                      Icon(
                                        list1[index]['isSelect']
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        color: list1[index]['isSelect']
                                            ? ColorUtils.white
                                            : ColorUtils.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))),
                  ),
                ),
                SizeConfig.sH3,
                Center(
                  child: AnimatedButton(
                      height: 12.w,
                      width: 60.w,
                      text: "REGISTER",
                      textStyle: FontTextStyle.Proxima14Regular.copyWith(
                          fontSize: 12.sp, color: ColorUtils.white),
                      borderRadius: 10.0,
                      backgroundColor: ColorUtils.primaryColor,
                      selectedBackgroundColor: ColorUtils.purple,
                      transitionType: TransitionType.CENTER_ROUNDER,
                      selectedTextColor: ColorUtils.white,
                      isReverse: true,
                      onPress: () async {
                        log("list ${list1.where((element) => element['isSelect'] == true).toList().isEmpty}");
                        FocusScope.of(context).requestFocus();
                        if (formkey.currentState!.validate()) {
                          // try {
                          final newuser = await _auth
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) {
                            firebase
                                .collection(_auth.currentUser!.uid)
                                .doc(_auth.currentUser!.uid)
                                .set({
                              'Full Name': fullnameController.text,
                              'Address': addressController.text,
                              'Company Name': companynameController.text,
                              'Email': emailController.text,
                              'Start date': dateController.text,
                              'Password': passwordController.text
                            });
                            firebase
                                .collection('Company List')
                                .doc(_auth.currentUser!.uid)
                                .set({
                              'Company Name': companynameController.text,
                              'uid': _auth.currentUser!.uid
                            });
                            Get.showSnackbar(
                              GetSnackBar(
                                message: "Register Succesfully",
                                borderRadius: 10.0,
                                margin: EdgeInsets.only(
                                    left: 4.w, right: 4.w, bottom: 4.w),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: ColorUtils.primaryColor,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            Future.delayed(
                              const Duration(seconds: 3),
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminLoginScreen()),
                                );
                              },
                            );
                          });

                          //} catch (e) {
                          //   print(e);
                          // }
                          setState(() {});
                        }
                      }),
                ),
                SizeConfig.sH1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account ?",
                      style: FontTextStyle.Proxima10Regular.copyWith(
                          color: ColorUtils.primaryColor,
                          fontWeight: FontWeightClass.semiB),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminLoginScreen()),
                          );
                        },
                        child: Text(
                          "Sign In",
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
      ),
    );
  }
}
