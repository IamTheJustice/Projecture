import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({Key? key}) : super(key: key);

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: projectList(),
    );
  }
}

Widget addMemberShimmer() {
  return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
    return Shimmer.fromColors(
      baseColor:
          themeNotifier.isDark ? Colors.grey : ColorUtils.grey.withOpacity(0.3),
      highlightColor: ColorUtils.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w),
              height: 9.h,
              width: 350,
              decoration: BoxDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 1.h),
              height: 9.h,
              width: 350,
              decoration: BoxDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 1.h),
              height: 9.h,
              width: 350,
              decoration: BoxDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 1.h),
              height: 9.h,
              width: 350,
              decoration: BoxDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 1.h),
              height: 9.h,
              width: 350,
              decoration: BoxDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 1.h),
              height: 9.h,
              width: 350,
              decoration: BoxDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 1.h),
              height: 9.h,
              width: 350,
              decoration: BoxDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w, top: 1.h),
              height: 9.h,
              width: 350,
              decoration: BoxDecoration(
                color: ColorUtils.black,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget projectList() {
  return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
    return Shimmer.fromColors(
      baseColor: themeNotifier.isDark ? Colors.grey : ColorUtils.purple,
      highlightColor: ColorUtils.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 12.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Container(
                height: 12.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Container(
                height: 12.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Container(
                height: 12.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Container(
                height: 12.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Container(
                height: 12.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Container(
                height: 12.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Container(
                height: 12.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget leaderList() {
  return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
    return Shimmer.fromColors(
      baseColor: themeNotifier.isDark ? Colors.grey : ColorUtils.primaryColor,
      highlightColor: ColorUtils.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 5.w),
              child: Container(
                height: 5.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget taskList() {
  return Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child) {
    return Shimmer.fromColors(
      baseColor: themeNotifier.isDark ? Colors.grey : ColorUtils.primaryColor,
      highlightColor: Colors.white12,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 4.w),
              child: Container(
                height: 38.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              child: Container(
                height: 38.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              child: Container(
                height: 38.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              child: Container(
                height: 38.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              child: Container(
                height: 38.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              child: Container(
                height: 38.h,
                width: Get.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: ColorUtils.purple),
              ),
            ),
          ],
        ),
      ),
    );
  });
}
