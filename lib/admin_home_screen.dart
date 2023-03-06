import 'package:flutter/material.dart';
import 'package:projecture_admin/adfmin_AddProject_screen.dart';
import 'package:projecture_admin/admin_dashBoard_screen.dart';
import 'package:projecture_admin/admin_leader_screen.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:sizer/sizer.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddProjectScreen()));
          },
          child: Container(
            height: 10.h,
            width: 30.w,
            color: Colors.yellow,
            child: Text("ADD PROJECT"),
          ),
        ),
        SizeConfig.sH2,
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashBoardScreen()));
          },
          child: Container(
            height: 10.h,
            width: 30.w,
            color: Colors.pink,
            child: Text("DashBoard"),
          ),
        ),
        SizeConfig.sH2,
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LeaderScreen()));
          },
          child: Container(
            height: 10.h,
            width: 30.w,
            color: Colors.blueGrey,
            child: Text("Leader"),
          ),
        ),
      ],
    ));
  }
}
