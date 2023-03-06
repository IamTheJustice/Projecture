import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:sizer/sizer.dart';

class AdminNoticeScreen extends StatefulWidget {
  const AdminNoticeScreen({Key? key}) : super(key: key);

  @override
  State<AdminNoticeScreen> createState() => _AdminNoticeScreenState();
}

class _AdminNoticeScreenState extends State<AdminNoticeScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController noticeNameController = TextEditingController();
  final TextEditingController noticeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime date = DateTime.now();
  late var formattedDate = "Date of Notice";
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notice"),
          centerTitle: true,
          iconTheme: const IconThemeData(color: ColorUtils.white),
          backgroundColor: ColorUtils.primaryColor,
        ),
        backgroundColor: ColorUtils.white,
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizeConfig.sH2,
                    Center(
                      child: Lottie.asset("assets/icons/notice.json",
                          height: 50.w),
                    ),
                    Text(
                      "create your notice",
                      style: FontTextStyle.Proxima16Medium.copyWith(
                          color: ColorUtils.primaryColor,
                          fontWeight: FontWeightClass.semiB),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.h),
                  child: TextFormField(
                    controller: noticeNameController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "please notice name required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Notice Name",
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
                    maxLines: 5,
                    controller: noticeController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "please notice required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(4.w),
                        filled: true,
                        fillColor: ColorUtils.greyE7.withOpacity(0.5),
                        hintText: "Notice",
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
                SizeConfig.sH3,
                AnimatedButton(
                    height: 12.w,
                    width: 60.w,
                    text: "SUBMIT",
                    textStyle: FontTextStyle.Proxima14Regular.copyWith(
                        fontSize: 12.sp, color: ColorUtils.white),
                    borderRadius: 10.0,
                    backgroundColor: ColorUtils.primaryColor,
                    selectedBackgroundColor: ColorUtils.purple,
                    transitionType: TransitionType.CENTER_ROUNDER,
                    selectedTextColor: ColorUtils.white,
                    isReverse: true,
                    onPress: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (formkey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection(_auth.currentUser!.uid)
                            .doc(_auth.currentUser!.uid)
                            .collection('Notice')
                            .doc()
                            .set({
                          'Notice Title': noticeNameController.text,
                          'Description': noticeController.text,
                          'Date': dateController.text
                        });
                        Get.showSnackbar(
                          GetSnackBar(
                            message: "Notice Added Succesfully",
                            borderRadius: 10.0,
                            margin: EdgeInsets.only(
                                left: 4.w, right: 4.w, bottom: 4.w),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: ColorUtils.primaryColor,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        // Future.delayed(
                        //   const Duration(seconds: 3),
                        //   () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const LoginScreen()),
                        //     );
                        //   },
                        // );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
