import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/const/function/local_notification_services.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LeaderAssign extends StatefulWidget {
  String projectName;
  LeaderAssign({super.key, required this.projectName});

  @override
  State<LeaderAssign> createState() => _LeaderAssignState();
}

class _LeaderAssignState extends State<LeaderAssign> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String projectName = widget.projectName;
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
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(_auth.currentUser!.uid)
                      .doc(_auth.currentUser!.uid)
                      .collection(projectName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(top: 2.h),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            var data = snapshot.data!.docs[i];
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 0.8.h),
                              child: Card(
                                elevation: 3.0,
                                child: ListTile(
                                  title: Text(data['Name']),
                                  subtitle: Text(data['Email']),
                                  trailing: MaterialButton(
                                    color: themeNotifier.isDark
                                        ? ColorUtils.white
                                        : ColorUtils.primaryColor,
                                    child: Text(
                                      "leader",
                                      style: FontTextStyle.Proxima14Regular
                                          .copyWith(
                                              color: themeNotifier.isDark
                                                  ? ColorUtils.primaryColor
                                                  : ColorUtils.white),
                                    ),
                                    onPressed: () async {
                                      try {
                                        await LocalNotificationServices
                                            .sendNotification(
                                          token: data['fcmToken'],
                                          message:
                                              "Congratulation....you are now project leader for ${projectName}....please login again for more rights",
                                          title: "Hurrah !!!",
                                        );
                                      } catch (e) {
                                        log('Eroorrr :$e');
                                      }
                                      FirebaseFirestore.instance
                                          .collection(_auth.currentUser!.uid)
                                          .doc(_auth.currentUser!.uid)
                                          .collection('Leader')
                                          .doc(data['Uid'])
                                          .set({
                                        'Name': data['Name'],
                                        'EMAIL': data['Email'],
                                      });
                                      FirebaseFirestore.instance
                                          .collection(_auth.currentUser!.uid)
                                          .doc(_auth.currentUser!.uid)
                                          .collection('Leader')
                                          .doc(data['Uid'])
                                          .collection("LEADING PROJECTS")
                                          .doc(projectName)
                                          .set({'Project name': projectName});
                                    },
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: ColorUtils.primaryColor,
                        strokeWidth: 1.1,
                      ));
                    }
                  }),
            ),
          ],
        ),
      );
    });
  }
}
