import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/shimmer_effect.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:sizer/sizer.dart';

class Checking extends StatefulWidget {
  var Project;
  Checking({super.key, this.Project});

  @override
  State<Checking> createState() => _CheckingState();
}

class _CheckingState extends State<Checking> {
  final _auth = FirebaseAuth.instance;
  bool isShimmer = true;
  Future durationShimmer() async {
    await Future.delayed(Duration(milliseconds: 500));
    isShimmer = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    durationShimmer();
  }

  @override
  Widget build(BuildContext context) {
    String Project = widget.Project;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
            child: isShimmer == true
                ? taskList()
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(_auth.currentUser!.uid)
                        .doc(_auth.currentUser!.uid)
                        .collection(Project)
                        .doc(Project)
                        .collection('InChecking')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            padding: EdgeInsets.only(top: 2.h),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = snapshot.data!.docs[index];
                              DateTime LastDate =
                                  DateTime.parse(data['LastDate']);
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.w, horizontal: 4.w),
                                    child: Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              ColorUtils.primaryColor,
                                              ColorUtils.purple,
                                              ColorUtils.purple
                                                  .withOpacity(0.8),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.deepPurple.shade400,
                                              offset: const Offset(0, 3),
                                              blurRadius: 15,
                                              spreadRadius: -5,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 3.w, bottom: 2.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizeConfig.sH2,
                                              Row(
                                                children: [
                                                  Text(
                                                    "Task Name : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                  Text(
                                                    data['task'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                ],
                                              ),
                                              SizeConfig.sH2,
                                              data['Image'] == ""
                                                  ? Center(
                                                      child: Column(
                                                        children: [
                                                          Lottie.asset(
                                                              "assets/icons/noImage.json",
                                                              height: 10.w),
                                                          Text(
                                                            " No Image",
                                                            style: FontTextStyle
                                                                    .Proxima16Medium
                                                                .copyWith(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Center(
                                                      child: FullScreenWidget(
                                                        backgroundIsTransparent:
                                                            true,
                                                        disposeLevel:
                                                            DisposeLevel.Medium,
                                                        child: Container(
                                                          height: 25.h,
                                                          width: 50.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: ColorUtils
                                                                      .white)),
                                                          child: Image.network(
                                                            data['Image'],
                                                            height: 25.h,
                                                            width: 50.w,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              SizeConfig.sH2,
                                              Row(
                                                children: [
                                                  Text(
                                                    "Assign Date : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                  Text(
                                                    data['AssignDate'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                ],
                                              ),
                                              SizeConfig.sH05,
                                              Row(
                                                children: [
                                                  Text(
                                                    "Due Date : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                  Text(
                                                    "${LastDate.year}-${LastDate.month}-${LastDate.day}",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                ],
                                              ),
                                              SizeConfig.sH05,
                                              Row(
                                                children: [
                                                  Text(
                                                    "Starting Date : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                  Text(
                                                    data['StartingDate'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                ],
                                              ),
                                              SizeConfig.sH05,
                                              Row(
                                                children: [
                                                  Text(
                                                    "CheckRequestDate : white",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                  Text(
                                                    data['CheckRequestDate'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                ],
                                              ),
                                              SizeConfig.sH05,
                                              Row(
                                                children: [
                                                  Text(
                                                    "User Name  : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                  Text(
                                                    data['Email'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                ],
                                              ),
                                              SizeConfig.sH05,
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            ColorUtils.white),
                                                    color:
                                                        ColorUtils.primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.5.h,
                                                      left: 3.w,
                                                      right: 3.w,
                                                      bottom: 0.5.h),
                                                  child: Text(
                                                    data['Name'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeightClass
                                                                    .extraB,
                                                            color: ColorUtils
                                                                .white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorUtils.primaryColor,
                            strokeWidth: 1.1,
                          ),
                        );
                      }
                    })),
      ),
    );
  }
}
