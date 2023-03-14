import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:projecture_admin/project_list_screen.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
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
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Project List"),
          centerTitle: true,
          backgroundColor: ColorUtils.primaryColor,
          iconTheme: const IconThemeData(color: ColorUtils.white),
        ),
        body: Form(
          key: formkey,
          child: Column(
            children: [
              SizeConfig.sH2,
              Padding(
                padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  cursorColor: ColorUtils.primaryColor,
                  controller: projectNameController,
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
                  textInputAction: TextInputAction.next,
                  cursorColor: ColorUtils.primaryColor,
                  controller: editingPlatformController,
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
                      hintText: "Editing Platform",
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
                  cursorColor: ColorUtils.primaryColor,
                  controller: descriptionController,
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
                      hintText: "Description",
                      hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                          color: ColorUtils.primaryColor),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
              ),
              SizeConfig.sH2,
              Center(
                child: AnimatedButton(
                    height: 12.w,
                    width: 60.w,
                    text: "ADD PROJECT",
                    textStyle: FontTextStyle.Proxima14Regular.copyWith(
                        fontSize: 12.sp, color: ColorUtils.white),
                    borderRadius: 10.0,
                    backgroundColor: ColorUtils.primaryColor,
                    selectedBackgroundColor: ColorUtils.purple,
                    transitionType: TransitionType.CENTER_ROUNDER,
                    selectedTextColor: ColorUtils.white,
                    isReverse: true,
                    onPress: () {
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
                          backgroundColor: ColorUtils.primaryColor,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(_auth.currentUser!.uid)
                        .doc(_auth.currentUser!.uid)
                        .collection('user')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              var data = snapshot.data!.docs[i];
                              return InkWell(
                                onTap: () {
                                  snapshot.data!.docs[i].reference
                                      .collection('Invite')
                                      .add({
                                    'Email': data['Email'],
                                    'name': data['Name'],
                                    'PROJECT NAME': projectNameController.text,
                                    'PLATFORM': editingPlatformController.text,
                                    'DESCRIPTION': descriptionController.text,
                                  });

                                  setState(() {
                                    if (temparray.contains(data['Uid'])) {
                                      temparray.remove(data['Uid']);
                                    } else {
                                      temparray.add(data['Uid']);
                                    }
                                  });
                                },
                                child: ListTile(
                                    title: Text(data['Name']),
                                    subtitle: Text(data['Email']),
                                    trailing: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: temparray.contains(data['Uid'])
                                              ? Colors.red
                                              : Colors.green),
                                      child: Center(
                                          child: Text(
                                        temparray.contains(data['Uid'])
                                            ? 'REMOVE'
                                            : 'ADD',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )),
                              );
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
