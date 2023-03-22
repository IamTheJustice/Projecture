import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_shadow/drop_shadow.dart' as a;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:projecture_admin/admin_AddProject_screen.dart';
import 'package:projecture_admin/admin_dashBoard_screen.dart';
import 'package:projecture_admin/admin_event_screen.dart';
import 'package:projecture_admin/admin_leader_screen.dart';
import 'package:projecture_admin/upload_notice.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:sizer/sizer.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS83axnEHbv6LEONfAHt9T7cS4kCC9f_wuGvQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ-K1XPtIJZ5xX-83Qd6SlM4g2dTUIqgPTug&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfDSd-Cv7euPM3CRBBxOqK2XztgDmk0gPnWQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUgi8jrXm_4rSU4ldvdWZzdda8LNokK98Mhg&usqp=CAU",
  ];
  int current = 0;
  List<Map<String, dynamic>> templist = <Map<String, dynamic>>[
    {
      "icon": Icons.add,
      "imagepath": "assets/images/addProject.json",
      "title": 'Add Project',
    },
    {
      "icon": Icons.notifications_active_outlined,
      "imagepath": "assets/images/notice.json",
      "title": 'Notice'
    },
    {
      "icon": Icons.event,
      "imagepath": "assets/images/events.json",
      "title": 'Events',
    },
    {
      "icon": Icons.dashboard,
      "imagepath": "assets/images/dashboard.json",
      "title": 'DashBoard',
    },
    {
      "icon": Icons.dashboard,
      "imagepath": "assets/images/leader.json",
      "title": 'Leader',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                  items: [
                    for (int i = 0; i < imageList.length; i++)
                      Container(
                        alignment: Alignment.center,
                        child: a.DropShadow(
                          borderRadius: 20.0,
                          blurRadius: 5.0,
                          offset: const Offset(3, 3),
                          spread: 1,
                          child: Image.network(
                            height: 22.h,
                            width: 80.w,
                            imageList[i],
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ],
                  options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      },
                      autoPlay: true)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < imageList.length; i++)
                    Container(
                      height: 8,
                      width: 8,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: current == i
                              ? ColorUtils.primaryColor
                              : ColorUtils.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                                color: ColorUtils.greyCE,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(2, 2))
                          ]),
                    )
                ],
              ),
              GridView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.w,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: templist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    templist[index]['title'] == "Add Project"
                                        ? Get.to(() => const AddProjectScreen())
                                        : const SizedBox();
                                    templist[index]['title'] == "Notice"
                                        ? Get.to(
                                            () => const AdminNoticeScreen())
                                        : const SizedBox();
                                    templist[index]['title'] == "Events"
                                        ? Get.to(() => const AdminEventScreen())
                                        : const SizedBox();
                                    templist[index]['title'] == "DashBoard"
                                        ? Get.to(() => const DashBoardScreen())
                                        : const SizedBox();
                                    templist[index]['title'] == "Leader"
                                        ? Get.to(() => const LeaderScreen())
                                        : const SizedBox();
                                  },
                                  child: Container(
                                    height: 35.w,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 9.0,
                                              color: ColorUtils.black
                                                  .withOpacity(0.2),
                                              spreadRadius: 0.5),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(3.w),
                                        color:
                                            ColorUtils.white.withOpacity(0.9)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizeConfig.sH2,
                                        Lottie.asset(
                                            templist[index]['imagepath'],
                                            height: 10.h,
                                            width: 27.w)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 13.h, left: 5.w, right: 4.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 9.0,
                                          color:
                                              ColorUtils.black.withOpacity(0.2),
                                          spreadRadius: 0.5),
                                    ],
                                    color: ColorUtils.primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                height: 6.h,
                                width: 30.w,
                                child: Center(
                                  child: Text(
                                    templist[index]['title'],
                                    style:
                                        FontTextStyle.Proxima16Medium.copyWith(
                                            color: ColorUtils.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
