import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMembers extends StatefulWidget {
  var Project;
  AddMembers({this.Project});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  List<String> temparray = [];
  late String ProjectName = "";
  late String Description = "";
  late String EditingPlatform = "";
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String Project = widget.Project;
    return Scaffold(
      body: StreamBuilder(
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
                      onTap: () async {
                        final QuerySnapshot addmember = await FirebaseFirestore
                            .instance
                            .collection(_auth.currentUser!.uid)
                            .doc(_auth.currentUser!.uid)
                            .collection('Projects')
                            .get();
                        final List<DocumentSnapshot> documents = addmember.docs;
                        for (var doc in documents) {
                          if (doc.id == Project) {
                            ProjectName = doc.get('Project Name');
                            EditingPlatform = doc.get('Editing Platform');
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
                          'PROJECT NAME': ProjectName,
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          )),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
