<<<<<<< Updated upstream
import 'dart:developer';
=======
>>>>>>> Stashed changes
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:projecture_admin/admin_AddProject_screen.dart';
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
import 'package:projecture_admin/admin_Chat_screen.dart';
import 'package:projecture_admin/admin_MyProfile_screen.dart';
import 'package:projecture_admin/admin_dashBoard_screen.dart';
import 'package:projecture_admin/admin_home_screen.dart';
import 'package:projecture_admin/admin_leader_screen.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
<<<<<<< Updated upstream
import 'package:projecture_admin/auth/admin_login_screen.dart';
=======
import 'package:projecture_admin/screens/chat/chat_screen.dart';
>>>>>>> Stashed changes
import 'package:projecture_admin/upload_notice.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'admin_dashBoard_screen.dart';
import 'auth/admin_login_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  var pageAll = [
    const AdminHomeScreen(),
<<<<<<< Updated upstream
    const AdminChatScreen(),
    const MyProfileScreen(),
  ];
  @override
  void initState() {
    setData();
    super.initState();
  }

  String? id;
  String? uid;
  setData() async {
    final pref = await SharedPreferences.getInstance();
    id = pref.getString("companyId");
    uid = pref.getString("userId");
    log("""
    
   userid       ${pref.getString("userId")};
    company id -- ${pref.getString("companyId")};
    """);
    setState(() {});
  }

=======
    const ChatScreen(),
    const MyProfileScreen(),
  ];
  bool circular = false;
  String imageUrl = '';
>>>>>>> Stashed changes
  final _auth = FirebaseAuth.instance;
  var myIndex = 0;
  String imageUrl = '';
  bool circular = false;
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black26,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        drawer: Drawer(
          backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView(
              primary: false,
              children: [
                SizeConfig.sH1,
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(_auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 22.h,
                          child: ListView.builder(
                              shrinkWrap: false,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, i) {
                                var data = snapshot.data!.docs[i];
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          data['ProfileImage'] == ""
                                              ? CircleAvatar(
                                                  radius: 50.0,
                                                  backgroundColor:
                                                      ColorUtils.primaryColor,
                                                  child: circular == true
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () async {
                                                            circular = true;
                                                            setState(() {});
                                                            ImagePicker
                                                                imagePicker =
                                                                ImagePicker();
                                                            XFile? file =
                                                                await imagePicker
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                            print(
                                                                '${file?.path}');

                                                            if (file == null) {
                                                              return;
                                                            }

                                                            Reference
                                                                referenceRoot =
                                                                FirebaseStorage
                                                                    .instance
                                                                    .ref();
                                                            Reference
                                                                referenceDirImages =
                                                                referenceRoot
                                                                    .child(
                                                                        'images');

                                                            Reference
                                                                referenceImageToUpload =
                                                                referenceDirImages
                                                                    .child(file
                                                                        .name);

                                                            try {
                                                              await referenceImageToUpload
                                                                  .putFile(File(
                                                                          file!
                                                                              .path)
                                                                      .absolute);

                                                              imageUrl =
                                                                  await referenceImageToUpload
                                                                      .getDownloadURL();
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(_auth
                                                                      .currentUser!
                                                                      .uid)
                                                                  .doc(_auth
                                                                      .currentUser!
                                                                      .uid)
                                                                  .update({
                                                                'ProfileImage':
                                                                    imageUrl
                                                              });
                                                              circular = false;
                                                              setState(() {});
                                                            } catch (error) {
                                                              //Some error occurred
                                                            }
                                                          },
                                                          icon: const Icon(Icons
                                                              .camera_alt)),
                                                )
                                              : Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: 25.w,
                                                      width: 25.w,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(150),
                                                        child: Image.network(
                                                          data['ProfileImage'],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.h, left: 15.w),
                                                      child: Container(
                                                        height: 4.h,
                                                        width: 8.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: ColorUtils
                                                                .primaryColor),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: ColorUtils
                                                                .white,
                                                            size: 4.w,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          IconButton(
                                              onPressed: () {
                                                themeNotifier.isDark =
                                                    !themeNotifier.isDark;
                                              },
                                              icon: themeNotifier.isDark
                                                  ? const Icon(
                                                      Icons.nights_stay,
                                                      color: ColorUtils.white,
                                                      size: 30.0,
                                                    )
                                                  : const Icon(
                                                      Icons.wb_sunny,
                                                      color: ColorUtils.black,
                                                      size: 30.0,
                                                    )),
                                        ],
                                      ),
                                      SizeConfig.sH2,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['Company Name'],
                                            style: FontTextStyle.Proxima16Medium
                                                .copyWith(
                                                    color: themeNotifier.isDark
                                                        ? ColorUtils.white
                                                        : ColorUtils
                                                            .primaryColor,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeightClass.semiB),
                                          ),
                                          Text(
                                            data['Email'],
                                            style: FontTextStyle.Proxima16Medium
                                                .copyWith(
                                              color: themeNotifier.isDark
                                                  ? ColorUtils.white
                                                  : ColorUtils.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorUtils.primaryColor,
                            strokeWidth: 1.1,
                          ),
                        );
                      }
                    }),
                const Divider(
                  thickness: 1,
                  color: ColorUtils.greyB6,
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const AddProjectScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: Icon(
                    Icons.add_box_outlined,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.grey79,
                  ),
                  title: Text(
                    'Add Project',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const AdminNoticeScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: Icon(
                    Icons.insert_invitation,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.grey79,
                  ),
                  title: Text(
                    'Notice',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        fontSize: 11.sp),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const LeaderScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: Icon(
                    Icons.man,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.grey79,
                  ),
                  title: Text(
                    'Leader',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const DashBoardScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: Icon(
                    Icons.dashboard,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.grey79,
                  ),
                  title: Text(
                    'Dashboard',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Column(
                              children: [
                                Text(
                                  'Log out',
                                  style: FontTextStyle.Proxima16Medium.copyWith(
                                      color: ColorUtils.primaryColor,
                                      fontWeight: FontWeightClass.extraB,
                                      fontSize: 13.sp),
                                ),
                                SizeConfig.sH1,
                                Lottie.asset("assets/images/logout.json",
                                    height: 25.w),
                              ],
                            ),
                            content: Text('are you sure you want to log out?',
                                style: FontTextStyle.Proxima16Medium.copyWith(
                                    color: ColorUtils.primaryColor)),
                            actions: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => AdminLoginScreen());
                                },
                                child: Container(
                                  height: 10.w,
                                  width: 25.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      color: ColorUtils.primaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Done",
                                      style: TextStyle(color: ColorUtils.white),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  height: 10.w,
                                  width: 25.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      color: ColorUtils.primaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: ColorUtils.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: ColorUtils.redColor,
                  ),
                  title: Text(
                    'Log out',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: ColorUtils.redColor),
                  ),
                ),
                SizeConfig.sH5,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Finding this app usefull?",
                        style: FontTextStyle.Proxima12Regular.copyWith(
                            color: ColorUtils.greyBB),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/drawerImage.svg'),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/sucessfully.svg'),
                      SizeConfig.sW2,
                      SvgPicture.asset('assets/icons/unsucessfully.svg'),
                      SizeConfig.sW2,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
<<<<<<< Updated upstream
=======
          // automaticallyImplyLeading: false,
>>>>>>> Stashed changes
          backgroundColor:
              themeNotifier.isDark ? ColorUtils.black : ColorUtils.primaryColor,
          title: Text(
            "Projecture",
            style: FontTextStyle.Proxima16Medium.copyWith(
                fontSize: 17.sp, color: ColorUtils.white),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: ColorUtils.white),
<<<<<<< Updated upstream
        ),
        drawer: Drawer(
          backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView(
              primary: false,
              children: [
                SizeConfig.sH1,
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(_auth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 22.h,
                          child: ListView.builder(
                              shrinkWrap: false,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, i) {
                                var data = snapshot.data!.docs[i];
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          data['ProfileImage'] == ""
                                              ? CircleAvatar(
                                                  radius: 50.0,
                                                  backgroundColor:
                                                      ColorUtils.primaryColor,
                                                  child: circular == true
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () async {
                                                            circular = true;
                                                            setState(() {});
                                                            ImagePicker
                                                                imagePicker =
                                                                ImagePicker();
                                                            XFile? file =
                                                                await imagePicker
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                            print(
                                                                '${file?.path}');

                                                            if (file == null) {
                                                              return;
                                                            }

                                                            Reference
                                                                referenceRoot =
                                                                FirebaseStorage
                                                                    .instance
                                                                    .ref();
                                                            Reference
                                                                referenceDirImages =
                                                                referenceRoot
                                                                    .child(
                                                                        'images');

                                                            Reference
                                                                referenceImageToUpload =
                                                                referenceDirImages
                                                                    .child(file
                                                                        .name);

                                                            try {
                                                              await referenceImageToUpload
                                                                  .putFile(File(
                                                                          file!
                                                                              .path)
                                                                      .absolute);

                                                              imageUrl =
                                                                  await referenceImageToUpload
                                                                      .getDownloadURL();
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(_auth
                                                                      .currentUser!
                                                                      .uid)
                                                                  .doc(_auth
                                                                      .currentUser!
                                                                      .uid)
                                                                  .update({
                                                                'ProfileImage':
                                                                    imageUrl
                                                              });
                                                              circular = false;
                                                              setState(() {});
                                                            } catch (error) {
                                                              //Some error occurred
                                                            }
                                                          },
                                                          icon: const Icon(Icons
                                                              .camera_alt)),
                                                )
                                              : Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: 25.w,
                                                      width: 25.w,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(150),
                                                        child: Image.network(
                                                          data['ProfileImage'],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.h, left: 15.w),
                                                      child: Container(
                                                        height: 4.h,
                                                        width: 8.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: ColorUtils
                                                                .primaryColor),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: ColorUtils
                                                                .white,
                                                            size: 4.w,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          IconButton(
                                              onPressed: () {
                                                themeNotifier.isDark =
                                                    !themeNotifier.isDark;
                                              },
                                              icon: themeNotifier.isDark
                                                  ? const Icon(
                                                      Icons.nights_stay,
                                                      color: ColorUtils.white,
                                                      size: 30.0,
                                                    )
                                                  : const Icon(
                                                      Icons.wb_sunny,
                                                      color: ColorUtils.black,
                                                      size: 30.0,
                                                    )),
                                        ],
                                      ),
                                      SizeConfig.sH2,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['Company Name'],
                                            style: FontTextStyle.Proxima16Medium
                                                .copyWith(
                                                    color: themeNotifier.isDark
                                                        ? ColorUtils.white
                                                        : ColorUtils
                                                            .primaryColor,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeightClass.semiB),
                                          ),
                                          Text(
                                            data['Email'],
                                            style: FontTextStyle.Proxima16Medium
                                                .copyWith(
                                              color: themeNotifier.isDark
                                                  ? ColorUtils.white
                                                  : ColorUtils.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorUtils.primaryColor,
                            strokeWidth: 1.1,
                          ),
                        );
                      }
                    }),
                const Divider(
                  thickness: 1,
                  color: ColorUtils.greyB6,
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const AddProjectScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: Icon(
                    Icons.add_box_outlined,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.grey79,
                  ),
                  title: Text(
                    'Add Project',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const AdminNoticeScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: Icon(
                    Icons.insert_invitation,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.grey79,
                  ),
                  title: Text(
                    'Notice',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        fontSize: 11.sp),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const LeaderScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: Icon(
                    Icons.man,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.grey79,
                  ),
                  title: Text(
                    'Leader',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const DashBoardScreen());
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: Icon(
                    Icons.dashboard,
                    color: themeNotifier.isDark
                        ? ColorUtils.white
                        : ColorUtils.grey79,
                  ),
                  title: Text(
                    'Dashboard',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Column(
                              children: [
                                Text(
                                  'Log out',
                                  style: FontTextStyle.Proxima16Medium.copyWith(
                                      color: ColorUtils.primaryColor,
                                      fontWeight: FontWeightClass.extraB,
                                      fontSize: 13.sp),
                                ),
                                SizeConfig.sH1,
                                Lottie.asset("assets/images/logout.json",
                                    height: 25.w),
                              ],
                            ),
                            content: Text('are you sure you want to log out?',
                                style: FontTextStyle.Proxima16Medium.copyWith(
                                    color: ColorUtils.primaryColor)),
                            actions: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => AdminLoginScreen());
                                },
                                child: Container(
                                  height: 10.w,
                                  width: 25.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      color: ColorUtils.primaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Done",
                                      style: TextStyle(color: ColorUtils.white),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  height: 10.w,
                                  width: 25.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      color: ColorUtils.primaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: ColorUtils.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: ColorUtils.redColor,
                  ),
                  title: Text(
                    'Log out',
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: ColorUtils.redColor),
                  ),
                ),
                SizeConfig.sH5,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Finding this app usefull?",
                        style: FontTextStyle.Proxima12Regular.copyWith(
                            color: ColorUtils.greyBB),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/drawerImage.svg'),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/sucessfully.svg'),
                      SizeConfig.sW2,
                      SvgPicture.asset('assets/icons/unsucessfully.svg'),
                      SizeConfig.sW2,
                    ],
                  ),
                ),
              ],
=======
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 1.h),
              child: Row(
                children: [
                  // IconButton(
                  //     onPressed: () {
                  //       Get.to(() => CardDetailsScreen());
                  //     },
                  //     icon: Icon(Icons.add_chart)),
                  IconButton(
                      onPressed: () {
                        themeNotifier.isDark = !themeNotifier.isDark;
                      },
                      icon: themeNotifier.isDark
                          ? const Icon(
                              Icons.nights_stay,
                              color: ColorUtils.white,
                              size: 25.0,
                            )
                          : const Icon(
                              Icons.wb_sunny,
                              color: ColorUtils.white,
                              size: 25.0,
                            )),
                ],
              ),
>>>>>>> Stashed changes
            ),
          ),
        ),
        body: pageAll[myIndex],
        bottomNavigationBar: Container(
          height: 7.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.9,
                  color: ColorUtils.black.withOpacity(0.2),
                  blurRadius: 5.0)
            ],
            color: themeNotifier.isDark ? ColorUtils.black : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    myIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: themeNotifier.isDark
                            ? myIndex == 0
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 0
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.home,
                      color: themeNotifier.isDark
                          ? myIndex == 0
                              ? ColorUtils.purple
                              : ColorUtils.white
                          : myIndex == 0
                              ? ColorUtils.purpleColor
                              : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Home",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color: themeNotifier.isDark
                            ? myIndex == 0
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 0
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    myIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: themeNotifier.isDark
                            ? myIndex == 1
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 1
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.chat,
                      color: themeNotifier.isDark
                          ? myIndex == 1
                              ? ColorUtils.purple
                              : ColorUtils.white
                          : myIndex == 1
                              ? ColorUtils.purpleColor
                              : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Chat",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color: themeNotifier.isDark
                            ? myIndex == 1
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 1
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    myIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: themeNotifier.isDark
                            ? myIndex == 2
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 2
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.account_circle,
                      color: themeNotifier.isDark
                          ? myIndex == 2
                              ? ColorUtils.purple
                              : ColorUtils.white
                          : myIndex == 2
                              ? ColorUtils.purpleColor
                              : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Profile",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color: themeNotifier.isDark
                            ? myIndex == 2
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 2
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
