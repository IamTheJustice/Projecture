import 'package:flutter/material.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:sizer/sizer.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Project"),
            centerTitle: true,
            backgroundColor: ColorUtils.primaryColor,
            iconTheme: const IconThemeData(color: ColorUtils.white),
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 7.h,
                  decoration: const BoxDecoration(
                      color: ColorUtils.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TabBar(
                      labelPadding: EdgeInsets.zero,
                      indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0)),
                      labelColor: ColorUtils.primaryColor,
                      labelStyle: FontTextStyle.Proxima14Regular.copyWith(
                          fontWeight: FontWeightClass.bold),
                      unselectedLabelColor: ColorUtils.white,
                      unselectedLabelStyle:
                          FontTextStyle.Proxima14Regular.copyWith(
                              fontWeight: FontWeightClass.semiB),
                      tabs: const [
                        Tab(
                          text: 'To Do',
                        ),
                        Tab(
                          text: 'Process',
                        ),
                        Tab(
                          text: 'Give Task',
                        ),
                        Tab(
                          text: 'Done',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    Center(
                      child: Text("Chats"),
                    ),
                    Center(
                      child: Text("status"),
                    ),
                    Center(
                      child: Text("calls"),
                    ),
                    Center(
                      child: Text("status"),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
