import 'package:flutter/material.dart';

import 'package:projecture_admin/admin_Chat_screen.dart';
import 'package:projecture_admin/admin_MyProfile_screen.dart';
import 'package:projecture_admin/admin_home_screen.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:sizer/sizer.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  var pageAll = [
    const AdminHomeScreen(),
    const AdminChatScreen(),
    const MyProfileScreen(),
  ];

  var myIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorUtils.primaryColor,
        title: Text(
          "Projecture",
          style: FontTextStyle.Proxima16Medium.copyWith(
              fontSize: 17.sp, color: ColorUtils.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorUtils.white),
      ),
      body: pageAll[myIndex],
      bottomNavigationBar: Container(
        height: 7.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                spreadRadius: 0.9,
                color: ColorUtils.black.withOpacity(0.2),
                blurRadius: 5.0)
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  myIndex = 0;
                });
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color:
                            myIndex == 0 ? Colors.red : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.home,
                      color:
                          myIndex == 0 ? Colors.red : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Home",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color:
                            myIndex == 0 ? Colors.red : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  myIndex = 1;
                });
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color:
                            myIndex == 1 ? Colors.red : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.chat,
                      color:
                          myIndex == 1 ? Colors.red : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Chat",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color:
                            myIndex == 1 ? Colors.red : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  myIndex = 2;
                });
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color:
                            myIndex == 2 ? Colors.red : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.account_circle,
                      color:
                          myIndex == 2 ? Colors.red : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Profile",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color:
                            myIndex == 2 ? Colors.red : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
