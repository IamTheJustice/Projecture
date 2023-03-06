import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LeaderAssign extends StatefulWidget {
  String projectName;
  LeaderAssign({required this.projectName});

  @override
  State<LeaderAssign> createState() => _LeaderAssignState();
}

class _LeaderAssignState extends State<LeaderAssign> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String projectName = widget.projectName;
    return Scaffold(
      backgroundColor: Colors.white,
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
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          return ListTile(
                            title: Text(data['Name']),
                            subtitle: Text(data['Email']),
                            trailing: MaterialButton(
                              child: Text("leader"),
                              onPressed: () {
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
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
