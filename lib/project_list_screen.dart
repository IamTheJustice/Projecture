import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:sizer/sizer.dart';

class ProjectListScreen extends StatefulWidget {
  String projectName;
  String editingPlatform;
  String description;

  ProjectListScreen(
      {required this.projectName,
      required this.editingPlatform,
      required this.description});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final String ProjectName = widget.projectName;
    final String EditingPlatform = widget.editingPlatform;
    final String Description = widget.description;
    List<String> temparray = [];
    // bool value = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Project List"),
        centerTitle: true,
        backgroundColor: ColorUtils.primaryColor,
        iconTheme: const IconThemeData(color: ColorUtils.white),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 20.h,
          child: StreamBuilder<QuerySnapshot>(
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
                              'PROJECT NAME': ProjectName,
                              'PLATFORM': EditingPlatform,
                              'DESCRIPTION': Description,
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: temparray.contains(data['Uid'])
                                        ? Colors.red
                                        : Colors.green),
                                child: Center(
                                    child: Text(
                                  temparray.contains(data['Uid'])
                                      ? 'REMOVE'
                                      : 'ADD',
                                  style: const TextStyle(
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
      ),
    );
  }
}
