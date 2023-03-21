import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecture_admin/addMembers_screen.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/task_screen.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Project List"),
          centerTitle: true,
          iconTheme: const IconThemeData(color: ColorUtils.white),
          backgroundColor:
              themeNotifier.isDark ? ColorUtils.black : ColorUtils.primaryColor,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(_auth.currentUser!.uid)
                    .doc(_auth.currentUser!.uid)
                    .collection('Projects')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: EdgeInsets.only(top: 2.h),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics:const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data!.docs[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.w, horizontal: 5.w),
                          child: Container(
                            width: Get.width,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: ColorUtils.purple),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.w),
                              child: Column(
                                children: [
                                  Text(
                                    data['Project Name'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        FontTextStyle.Proxima16Medium.copyWith(
                                            color: ColorUtils.white,
                                            fontSize: 13.sp),
                                  ),
                                  SizeConfig.sH2,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TaskScreen(
                                                          Project: data[
                                                              'Project Name'])));
                                        },
                                        child: Container(
                                          height: 4.h,
                                          width: 28.w,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0)),
                                            color: ColorUtils.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "SHOW DATA",
                                              style: FontTextStyle
                                                      .Proxima12Regular
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeightClass
                                                              .extraB,
                                                      color: ColorUtils.purple),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddMembers(
                                                          Project: data[
                                                              'Project Name'])));
                                        },
                                        child: Container(
                                          height: 4.h,
                                          width: 28.w,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0)),
                                            color: ColorUtils.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "ADD Member",
                                              style: FontTextStyle
                                                      .Proxima12Regular
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeightClass
                                                              .extraB,
                                                      color: ColorUtils.purple),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      );
    });
  }
}
