import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

class AdminEventScreen extends StatefulWidget {
  const AdminEventScreen({Key? key}) : super(key: key);

  @override
  State<AdminEventScreen> createState() => _AdminEventScreenState();
}

class _AdminEventScreenState extends State<AdminEventScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController noticeNameController = TextEditingController();
  final TextEditingController noticeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime date = DateTime.now();
  late var formattedDate = "Date of Event";
  TimeOfDay? _time;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return GestureDetector(
        onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Events"),
            centerTitle: true,
            iconTheme: const IconThemeData(color: ColorUtils.white),
            backgroundColor: themeNotifier.isDark
                ? ColorUtils.black
                : ColorUtils.primaryColor,
          ),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizeConfig.sH4,
                        Center(
                          child: Lottie.asset("assets/icons/event.json",
                              height: 40.w),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.h),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        cursorColor: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        controller: noticeNameController,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "please Events name required";
                          }
                          return null;
                        },
                        style: FontTextStyle.Proxima16Medium.copyWith(
                            color: themeNotifier.isDark
                                ? ColorUtils.white
                                : ColorUtils.primaryColor),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4.w),
                            filled: true,
                            fillColor: ColorUtils.greyE7.withOpacity(0.5),
                            hintText: "Event Name",
                            hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                                color: themeNotifier.isDark
                                    ? Colors.white60
                                    : ColorUtils.primaryColor),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        cursorColor: themeNotifier.isDark
                            ? ColorUtils.white
                            : ColorUtils.primaryColor,
                        maxLines: 5,
                        controller: noticeController,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "please Event description required";
                          }
                          return null;
                        },
                        style: FontTextStyle.Proxima16Medium.copyWith(
                            color: themeNotifier.isDark
                                ? ColorUtils.white
                                : ColorUtils.primaryColor),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4.w),
                            filled: true,
                            fillColor: ColorUtils.greyE7.withOpacity(0.5),
                            hintText: "Event Description",
                            hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                                color: themeNotifier.isDark
                                    ? Colors.white60
                                    : ColorUtils.primaryColor),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.w),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: dateController,
                        readOnly: true,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "please required date";
                          }
                          return null;
                        },
                        style: FontTextStyle.Proxima16Medium.copyWith(
                            color: themeNotifier.isDark
                                ? ColorUtils.white
                                : ColorUtils.primaryColor),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4.w),
                            filled: true,
                            fillColor: ColorUtils.greyE7.withOpacity(0.5),
                            hintText: formattedDate,
                            hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                                color: themeNotifier.isDark
                                    ? Colors.white60
                                    : ColorUtils.primaryColor),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: ColorUtils
                                        .primaryColor, // header background color
                                    onPrimary:
                                        ColorUtils.white, // header text color
                                    onSurface: ColorUtils
                                        .primaryColor, // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: ColorUtils
                                          .primaryColor, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                            initialDate: date,
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2030),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              formattedDate =
                                  DateFormat('d-MMM-yy').format(selectedDate);
                              setState(() {
                                dateController.text = formattedDate;
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 1.h),
                      child: TextFormField(
                        style: FontTextStyle.Proxima16Medium.copyWith(
                            color: themeNotifier.isDark
                                ? ColorUtils.white
                                : ColorUtils.primaryColor),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: ColorUtils.greyE7.withOpacity(0.5),
                            hintText: 'Select time',
                            hintStyle: FontTextStyle.Proxima14Regular.copyWith(
                                color: themeNotifier.isDark
                                    ? Colors.white60
                                    : ColorUtils.primaryColor),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                        readOnly: true,
                        onTap: () => _selectTime(context),
                        controller: TextEditingController(
                          text: _time?.format(context) ?? '',
                        ),
                        validator: (value) {
                          if (_time == null) {
                            return 'Please select a time';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizeConfig.sH3,
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (formkey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      Center(
                                        child: Lottie.asset(
                                            "assets/icons/eventtCelebration.json",
                                            height: 40.w),
                                      ),
                                    ],
                                  ),
                                  content: Text(
                                      'are you sure want to event Add?',
                                      textAlign: TextAlign.center,
                                      style: FontTextStyle.Proxima16Medium
                                          .copyWith(
                                              color: ColorUtils.primaryColor)),
                                  actions: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            message: "Event Added Succesfully",
                                            borderRadius: 10.0,
                                            margin: EdgeInsets.only(
                                                left: 4.w,
                                                right: 4.w,
                                                bottom: 4.w),
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                                themeNotifier.isDark
                                                    ? ColorUtils.black
                                                    : ColorUtils.primaryColor,
                                            duration:
                                                const Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 10.w,
                                        width: 25.w,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            color: ColorUtils.primaryColor),
                                        child: const Center(
                                          child: Text(
                                            "Done",
                                            style: TextStyle(
                                                color: ColorUtils.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        height: 10.w,
                                        width: 25.w,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                            color: ColorUtils.primaryColor),
                                        child: const Center(
                                          child: Text(
                                            "Cancle",
                                            style: TextStyle(
                                                color: ColorUtils.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: Container(
                        height: 6.5.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  ColorUtils.primaryColor,
                                  ColorUtils.primaryColor.withOpacity(0.5),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(
                                    5,
                                    5,
                                  ),
                                  blurRadius: 10)
                            ]),
                        child: Center(
                            child: Text(
                          "SUBMIT",
                          style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.white),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
