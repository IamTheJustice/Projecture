import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/leader_assignList_screen.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LeaderScreen extends StatefulWidget {
  const LeaderScreen({Key? key}) : super(key: key);

  @override
  State<LeaderScreen> createState() => _LeaderScreenState();
}

class _LeaderScreenState extends State<LeaderScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Project List"),
          centerTitle: true,
          backgroundColor:
              themeNotifier.isDark ? ColorUtils.black : ColorUtils.primaryColor,
          iconTheme: const IconThemeData(color: ColorUtils.white),
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
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, i) {
                          var data = snapshot.data!.docs[i];
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.8.h, horizontal: 6.w),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LeaderAssign(
                                          projectName: data['Project Name']);
                                    }));
                                  },
                                  child: Container(
                                    height: 5.5.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorUtils.greyBB
                                                .withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: themeNotifier.isDark
                                            ? ColorUtils.white
                                            : ColorUtils.primaryColor),
                                    child: Center(
                                      child: Text(
                                        data['Project Name'],
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: themeNotifier.isDark
                                                ? ColorUtils.primaryColor
                                                : ColorUtils.white),
                                      ),
                                    ),
                                  ),
                                ),
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
                }),
          ),
        ),
      );
    });
  }
}
