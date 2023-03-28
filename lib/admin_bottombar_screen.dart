import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:projecture_admin/admin_Chat_screen.dart';
import 'package:projecture_admin/admin_MyProfile_screen.dart';
import 'package:projecture_admin/admin_home_screen.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:provider/provider.dart';
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
    const MyProfile(),
  ];

  var myIndex = 0;
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black26,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor:
              themeNotifier.isDark ? ColorUtils.black : ColorUtils.primaryColor,
          title: Text(
            "Projecture",
            style: FontTextStyle.Proxima16Medium.copyWith(
                fontSize: 17.sp, color: ColorUtils.white),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: ColorUtils.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 1.h),
              child: IconButton(
                  onPressed: () {
                    themeNotifier.isDark = !themeNotifier.isDark;
                  },
                  icon: themeNotifier.isDark
                      ? const Icon(
                          Icons.nights_stay,
                          color: ColorUtils.white,
                          size: 25.0,
                        )
                      : const Icon(
                          Icons.wb_sunny,
                          color: ColorUtils.white,
                          size: 25.0,
                        )),
            ),
          ],
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
            color: themeNotifier.isDark ? ColorUtils.black : Colors.white,
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
                        color: themeNotifier.isDark
                            ? myIndex == 0
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 0
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.home,
                      color: themeNotifier.isDark
                          ? myIndex == 0
                              ? ColorUtils.purple
                              : ColorUtils.white
                          : myIndex == 0
                              ? ColorUtils.purpleColor
                              : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Home",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color: themeNotifier.isDark
                            ? myIndex == 0
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 0
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    myIndex = 1;
                  });
                },
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
                        color: themeNotifier.isDark
                            ? myIndex == 1
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 1
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.chat,
                      color: themeNotifier.isDark
                          ? myIndex == 1
                              ? ColorUtils.purple
                              : ColorUtils.white
                          : myIndex == 1
                              ? ColorUtils.purpleColor
                              : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Chat",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color: themeNotifier.isDark
                            ? myIndex == 1
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 1
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    myIndex = 2;
                  });
                },
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
                        color: themeNotifier.isDark
                            ? myIndex == 2
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 2
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                    SizeConfig.sH05,
                    Icon(
                      Icons.account_circle,
                      color: themeNotifier.isDark
                          ? myIndex == 2
                              ? ColorUtils.purple
                              : ColorUtils.white
                          : myIndex == 2
                              ? ColorUtils.purpleColor
                              : ColorUtils.primaryColor,
                    ),
                    Text(
                      "Profile",
                      style: FontTextStyle.Proxima14Regular.copyWith(
                        color: themeNotifier.isDark
                            ? myIndex == 2
                                ? ColorUtils.purple
                                : ColorUtils.white
                            : myIndex == 2
                                ? ColorUtils.purpleColor
                                : ColorUtils.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
