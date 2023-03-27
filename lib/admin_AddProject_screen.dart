import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController editingPlatformController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<String> temparray = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return GestureDetector(
        onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Project List"),
            centerTitle: true,
            backgroundColor: themeNotifier.isDark
                ? ColorUtils.black
                : ColorUtils.primaryColor,
            iconTheme: const IconThemeData(color: ColorUtils.white),
          ),
          body: SingleChildScrollView(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizeConfig.sH2,
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        cursorColor: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        controller: projectNameController,
                        style: FontTextStyle.Proxima16Medium.copyWith(
                          color: themeNotifier.isDark
                              ? ColorUtils.white
                              : ColorUtils.primaryColor,
                        ),
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
                            hintText: "Project Name",
                            hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                                color: themeNotifier.isDark
                                    ? Colors.white60
                                    : ColorUtils.primaryColor),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        cursorColor: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        controller: editingPlatformController,
                        maxLines: 2,
                        style: FontTextStyle.Proxima16Medium.copyWith(
                          color: themeNotifier.isDark
                              ? ColorUtils.white
                              : ColorUtils.primaryColor,
                        ),
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
                            hintText: "Editing Platform",
                            hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                                color: themeNotifier.isDark
                                    ? Colors.white60
                                    : ColorUtils.primaryColor),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                      child: TextFormField(
                        cursorColor: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        controller: descriptionController,
                        maxLines: 2,
                        style: FontTextStyle.Proxima16Medium.copyWith(
                          color: themeNotifier.isDark
                              ? ColorUtils.white
                              : ColorUtils.primaryColor,
                        ),
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
                            hintText: "Description",
                            hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                                color: themeNotifier.isDark
                                    ? Colors.white60
                                    : ColorUtils.primaryColor),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                    ),
                    SizeConfig.sH2,
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection(_auth.currentUser!.uid)
                              .doc(_auth.currentUser!.uid)
                              .collection("Projects")
                              .doc(projectNameController.text)
                              .set({
                            'Project Name': projectNameController.text,
                            'Editing Platform': editingPlatformController.text,
                            'Description': descriptionController.text,
                          });

                          Get.showSnackbar(
                            GetSnackBar(
                              message: "Add Project Successfully",
                              borderRadius: 10.0,
                              margin: EdgeInsets.only(
                                  left: 4.w, right: 4.w, bottom: 4.w),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: themeNotifier.isDark
                                  ? ColorUtils.black
                                  : ColorUtils.primaryColor,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                          height: 6.5.h,
                          width: 60.w,
                          decoration: themeNotifier.isDark
                              ? BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: ColorUtils.black)
                              : BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        ColorUtils.primaryColor,
                                        ColorUtils.primaryColor
                                            .withOpacity(0.5),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(
                                            5,
                                            5,
                                          ),
                                          blurRadius: 10)
                                    ]),
                          child: Center(
                              child: Text(
                            "ADD PROJECT",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                                color: ColorUtils.white),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, right: 5.w, left: 5.w),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: ColorUtils.greyBB.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ]),
                        child: Theme(
                          data: ThemeData(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            collapsedIconColor: ColorUtils.primaryColor,
                            iconColor: ColorUtils.primaryColor,
                            title: Text(
                              "Member",
                              style: FontTextStyle.Proxima16Medium.copyWith(
                                  color: ColorUtils.primaryColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeightClass.semiB),
                            ),
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 4.w, left: 4.w, top: 1.h),
                                    child: const Divider(
                                      color: ColorUtils.greyB6,
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 300,
                                    child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection(_auth.currentUser!.uid)
                                            .doc(_auth.currentUser!.uid)
                                            .collection('user')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                                padding: EdgeInsets.only(
                                                    bottom: 2.h),
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, i) {
                                                  var data =
                                                      snapshot.data!.docs[i];
                                                  return InkWell(
                                                    onTap: () {
                                                      snapshot.data!.docs[i]
                                                          .reference
                                                          .collection('Invite')
                                                          .add({
                                                        'Email': data['Email'],
                                                        'name': data['Name'],
                                                        'PROJECT NAME':
                                                            projectNameController
                                                                .text,
                                                        'PLATFORM':
                                                            editingPlatformController
                                                                .text,
                                                        'DESCRIPTION':
                                                            descriptionController
                                                                .text,
                                                      });
                                                      setState(() {
                                                        if (temparray.contains(
                                                            data['Uid'])) {
                                                          temparray.remove(
                                                              data['Uid']);
                                                        } else {
                                                          temparray
                                                              .add(data['Uid']);
                                                        }
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5.w,
                                                          left: 5.w,
                                                          top: 1.h),
                                                      child: Card(
                                                        elevation: 3.0,
                                                        child: ListTile(
                                                            title: Text(
                                                                data['Name']),
                                                            subtitle: Text(
                                                                data['Email']),
                                                            trailing: Container(
                                                              height: 40,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: temparray.contains(
                                                                          data[
                                                                              'Uid'])
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .green),
                                                              child: Center(
                                                                  child: Text(
                                                                temparray.contains(
                                                                        data[
                                                                            'Uid'])
                                                                    ? 'REMOVE'
                                                                    : 'ADD',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: ColorUtils.primaryColor,
                                              strokeWidth: 1.1,
                                            ));
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, right: 5.w, left: 5.w),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: ColorUtils.greyBB.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ]),
                        child: Theme(
                          data: ThemeData(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            collapsedIconColor: ColorUtils.primaryColor,
                            iconColor: ColorUtils.primaryColor,
                            title: Text(
                              "Client",
                              style: FontTextStyle.Proxima16Medium.copyWith(
                                  color: ColorUtils.primaryColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeightClass.semiB),
                            ),
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 4.w, left: 4.w, top: 1.h),
                                    child: const Divider(
                                      color: ColorUtils.greyB6,
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 300,
                                    child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection(_auth.currentUser!.uid)
                                            .doc(_auth.currentUser!.uid)
                                            .collection('Client')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                                padding: EdgeInsets.only(
                                                    bottom: 2.h),
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, i) {
                                                  var data =
                                                      snapshot.data!.docs[i];
                                                  return InkWell(
                                                    onTap: () {
                                                      snapshot.data!.docs[i]
                                                          .reference
                                                          .collection(
                                                              'ClientProject')
                                                          .add({
                                                        'Email': data['Email'],
                                                        'name': data['Name'],
                                                        'PROJECT NAME':
                                                            projectNameController
                                                                .text,
                                                        'PLATFORM':
                                                            editingPlatformController
                                                                .text,
                                                        'DESCRIPTION':
                                                            descriptionController
                                                                .text,
                                                      });
                                                      setState(() {
                                                        if (temparray.contains(
                                                            data['Uid'])) {
                                                          temparray.remove(
                                                              data['Uid']);
                                                        } else {
                                                          temparray
                                                              .add(data['Uid']);
                                                        }
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5.w,
                                                          left: 5.w,
                                                          top: 1.h),
                                                      child: Card(
                                                        elevation: 3.0,
                                                        child: ListTile(
                                                            title: Text(
                                                                data['Name']),
                                                            subtitle: Text(
                                                                data['Email']),
                                                            trailing: Container(
                                                              height: 40,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: temparray.contains(
                                                                          data[
                                                                              'Uid'])
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .green),
                                                              child: Center(
                                                                  child: Text(
                                                                temparray.contains(
                                                                        data[
                                                                            'Uid'])
                                                                    ? 'REMOVE'
                                                                    : 'ADD',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: ColorUtils.primaryColor,
                                              strokeWidth: 1.1,
                                            ));
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
