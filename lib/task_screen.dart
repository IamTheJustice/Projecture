import 'package:flutter/material.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/status/Checking_screen.dart';
import 'package:projecture_admin/status/Done.dart';
import 'package:projecture_admin/status/inprocess_screen.dart';
import 'package:projecture_admin/status/todo_screen.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TaskScreen extends StatefulWidget {
  var Project;
  TaskScreen({this.Project});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    String Project = widget.Project;
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Project"),
              centerTitle: true,
              backgroundColor: themeNotifier.isDark
                  ? ColorUtils.black
                  : ColorUtils.primaryColor,
              iconTheme: const IconThemeData(color: ColorUtils.white),
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizeConfig.sH2,
                  Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                        color: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TabBar(
                        labelPadding: EdgeInsets.zero,
                        indicator: BoxDecoration(
                            color: themeNotifier.isDark
                                ? ColorUtils.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(30.0)),
                        labelColor: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        labelStyle: FontTextStyle.Proxima14Regular.copyWith(
                            fontWeight: FontWeightClass.bold),
                        unselectedLabelColor: themeNotifier.isDark
                            ? ColorUtils.primaryColor
                            : ColorUtils.white,
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
                            text: 'InChecking',
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
                      TodoScreen(Project: Project),
                      InProcess(Project: Project),
                      Checking(Project: Project),
                      Done(Project: Project),
                    ],
                  ))
                ],
              ),
            ),
          ));
    });
  }
}
