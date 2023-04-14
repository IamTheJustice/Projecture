import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/const/function/local_notification_services.dart';
import 'package:projecture_admin/utils/shimmer_effect.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddMembers extends StatefulWidget {
  var Project;
  AddMembers({super.key, this.Project});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  List<String> temparray = [];
  late String ProjectName = "";
  late String Description = "";
  late String EditingPlatform = "";
  final _auth = FirebaseAuth.instance;
  bool isShimmer = true;
  Future durationShimmer() async {
    await Future.delayed(const Duration(milliseconds: 500));
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
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ADD MEMBER"),
          centerTitle: true,
          iconTheme: const IconThemeData(color: ColorUtils.white),
          backgroundColor:
              themeNotifier.isDark ? ColorUtils.black : ColorUtils.primaryColor,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: isShimmer == true
              ? addMemberShimmer()
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(_auth.currentUser!.uid)
                      .doc(_auth.currentUser!.uid)
                      .collection('user')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          padding: EdgeInsets.only(top: 2.h),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            var data = snapshot.data!.docs[i];
                            return InkWell(
                              onTap: () async {
                                final QuerySnapshot addmember =
                                    await FirebaseFirestore.instance
                                        .collection(_auth.currentUser!.uid)
                                        .doc(_auth.currentUser!.uid)
                                        .collection('Projects')
                                        .get();
                                final List<DocumentSnapshot> documents =
                                    addmember.docs;
                                for (var doc in documents) {
                                  if (doc.id == Project) {
                                    ProjectName = doc.get('Project Name');
                                    EditingPlatform =
                                        doc.get('Editing Platform');
                                    Description = doc.get('Description');
                                  }
                                }

                                FirebaseFirestore.instance
                                    .collection(_auth.currentUser!.uid)
                                    .doc(_auth.currentUser!.uid)
                                    .collection('user')
                                    .doc(data['Uid'])
                                    .collection('Current Project')
                                    .doc(Project)
                                    .set({
                                  'Project Name': ProjectName,
                                  'PLATFORM': EditingPlatform,
                                  'DESCRIPTION': Description,
                                });

                                FirebaseFirestore.instance
                                    .collection(_auth.currentUser!.uid)
                                    .doc(_auth.currentUser!.uid)
                                    .collection(Project)
                                    .doc(data['Uid'])
                                    .set({
                                  'Name': data['Name'],
                                  'Email': data['Email'],
                                  'Uid': data['Uid']
                                });
                                setState(() {
                                  if (temparray.contains(data['Uid'])) {
                                    temparray.remove(data['Uid']);
                                  } else {
                                    temparray.add(data['Uid']);
                                  }
                                });
                                try {
                                  await LocalNotificationServices.sendNotification(
                                      token: data['fcmToken'],
                                      message:
                                          'The company added you for a ${ProjectName} project',
                                      title: ProjectName);
                                } catch (e) {
                                  log('Eroorrr :$e');
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 5.w, right: 5.w, top: 1.h),
                                child: Card(
                                  elevation: 3.0,
                                  child: ListTile(
                                      title: Text(data['Name']),
                                      subtitle: Text(data['Email']),
                                      trailing: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                temparray.contains(data['Uid'])
                                                    ? Colors.red
                                                    : Colors.green),
                                        child: Center(
                                            child: Text(
                                          temparray.contains(data['Uid'])
                                              ? 'REMOVE'
                                              : 'ADD',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorUtils.white),
                                        )),
                                      )),
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
      );
    });
  }
}
