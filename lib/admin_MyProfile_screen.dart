import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'app_theme/model_theme.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    setData();
    super.initState();
  }

  String? cid;
  String? uid;
  setData() async {
    final pref = await SharedPreferences.getInstance();
    cid = pref.getString("companyId");
    uid = pref.getString("userId");
    log("""
    
   userid       ${pref.getString("userId")};
    company id -- ${pref.getString("companyId")};
    """);
    setState(() {});
  }

  final _auth = FirebaseAuth.instance;
  File? imageFile;
  final formkey = GlobalKey<FormState>();
  bool isCheckPassword = true;
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        backgroundColor:
            themeNotifier.isDark ? Colors.black.withOpacity(0.8) : Colors.white,
        body: Column(
          children: [
            Center(
              child: Container(
                child: imageFile != null
                    ? Container(
                        width: 31.w,
                        height: 31.w,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFFFF7171),
                                  Color(0xFFA156A0),
                                  Color(0xFF7564A0),
                                ])),
                        child: Container(
                          width: 29.w,
                          height: 29.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                image: FileImage(imageFile!),
                                fit: BoxFit.cover,
                              )),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtils.blueF0,
                          border: Border.all(
                              color: ColorUtils.purple,
                              width: 4.1,
                              style: BorderStyle.solid),
                        ),
                        height: 30.w,
                        width: 30.w,
                        child: Center(
                          child: Lottie.asset(
                            "assets/lotties/profile.json",
                          ),
                        ),
                      ),
              ),
            ),
            SizeConfig.sH1,
            Center(
                child: InkWell(
              onTap: () {
                chooseImageBottomSheet();
              },
              child: Text(
                "Upload picture",
                style: FontTextStyle.Proxima16Medium.copyWith(
                    decoration: TextDecoration.underline,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.primaryColor),
              ),
            )),
          ],
        ),
      );
    });
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future chooseImageBottomSheet() {
    return Get.bottomSheet(
        //isScrollControlled: true,
        //isDismissible: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))), StatefulBuilder(
      builder: ((context, setState) {
        return SizedBox(
          height: 34.w,
          child: Padding(
            padding: EdgeInsets.only(top: 1.h, right: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    color: ColorUtils.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              _getFromGallery();
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: ColorUtils.primaryColor,
                              radius: 25.0,
                              child: Icon(
                                Icons.add_photo_alternate_rounded,
                                color: ColorUtils.white,
                                size: 9.w,
                              ),
                            )),
                        SizeConfig.sH1,
                        Text(
                          "Gallery",
                          style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.primaryColor),
                        )
                      ],
                    ),
                    SizeConfig.sW4,
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              _getFromCamera();
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: ColorUtils.primaryColor,
                              radius: 25.0,
                              child: Icon(
                                Icons.camera,
                                color: ColorUtils.white,
                                size: 10.w,
                              ),
                            )),
                        SizeConfig.sH1,
                        Text(
                          "Camera",
                          style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.primaryColor),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }
}
