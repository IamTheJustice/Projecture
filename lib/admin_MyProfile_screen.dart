import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    setData();
    super.initState();
  }

  String? id;
  String? uid;
  final _auth = FirebaseAuth.instance;

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

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return GestureDetector(
        onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.sH5,
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(_auth.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              var data = snapshot.data!.docs[i];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorUtils.primaryColor,
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      SizeConfig.sH2,
                                      Center(
                                        child: Text(data['Company Name'],
                                            style: FontTextStyle.Proxima16Medium
                                                .copyWith(
                                                    color:
                                                        ColorUtils.primaryColor,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeightClass
                                                        .extraB)),
                                      ),
                                      SizeConfig.sH2,
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorUtils.purple,
                                                  width: 3)),
                                          child: Image.network(
                                            data['ProfileImage'],
                                            height: 20.h,
                                            width: 40.w,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 9.w, top: 2.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text("Full Name : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeightClass
                                                                    .semiB)),
                                                Text(data['Full Name'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                      color: ColorUtils
                                                          .primaryColor,
                                                    )),
                                              ],
                                            ),
                                            SizeConfig.sH1,
                                            Row(
                                              children: [
                                                Text("Address : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeightClass
                                                                    .semiB)),
                                                Text(data['Address'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                      color: ColorUtils
                                                          .primaryColor,
                                                    )),
                                              ],
                                            ),
                                            SizeConfig.sH1,
                                            Row(
                                              children: [
                                                Text("Start Date : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeightClass
                                                                    .semiB)),
                                                Text(data['Start date'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                      color: ColorUtils
                                                          .primaryColor,
                                                    )),
                                              ],
                                            ),
                                            SizeConfig.sH1,
                                            Row(
                                              children: [
                                                Text("Email : ",
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                            color: ColorUtils
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeightClass
                                                                    .semiB)),
                                                Text(data['Email'],
                                                    style: FontTextStyle
                                                            .Proxima16Medium
                                                        .copyWith(
                                                      color: ColorUtils
                                                          .primaryColor,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizeConfig.sH4,
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: ColorUtils.primaryColor),
                      );
                    }
                  }),
              SizeConfig.sH2,
            ],
          ),
        ),
      );
    });
  }
}
