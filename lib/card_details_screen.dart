import 'package:flutter/material.dart';
import 'package:projecture_admin/app_theme/model_theme.dart';
import 'package:projecture_admin/utils/color_utils.dart';
import 'package:projecture_admin/utils/fontStyle_utils.dart';
import 'package:projecture_admin/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return GestureDetector(
        onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Card"),
            centerTitle: true,
            backgroundColor: themeNotifier.isDark
                ? ColorUtils.black
                : ColorUtils.primaryColor,
            iconTheme: const IconThemeData(color: ColorUtils.white),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.sH4,
              Center(
                child: Text("Frontbit solution aa company name",
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: ColorUtils.primaryColor, fontSize: 14.sp)),
              ),
              SizeConfig.sH2,
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorUtils.purple, width: 3)),
                  child: Image.asset(
                    "assets/images/profile.png",
                    height: 15.h,
                    width: 30.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizeConfig.sH2,
              Center(
                child: Text("prachi jagani",
                    style: FontTextStyle.Proxima16Medium.copyWith(
                        color: ColorUtils.primaryColor, fontSize: 16.sp)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w, top: 1.h),
                child: Text("21,dhan society,simada naka,godhra",
                    style: FontTextStyle.Proxima16Medium.copyWith(
                      color: ColorUtils.primaryColor,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.w, top: 1.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("DOB : ",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.primaryColor,
                            )),
                        Text("25/12/2003",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.primaryColor,
                            )),
                      ],
                    ),
                    SizeConfig.sH05,
                    Row(
                      children: [
                        Text("phone no : ",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.primaryColor,
                            )),
                        Text("9987654325",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.primaryColor,
                            )),
                      ],
                    ),
                    SizeConfig.sH05,
                    Row(
                      children: [
                        Text("Email : ",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.primaryColor,
                            )),
                        Text("prachijagani23@gmailcom",
                            style: FontTextStyle.Proxima16Medium.copyWith(
                              color: ColorUtils.primaryColor,
                            )),
                      ],
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
