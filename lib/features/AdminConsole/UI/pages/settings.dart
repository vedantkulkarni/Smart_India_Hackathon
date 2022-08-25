import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

bool isSelectedEng = true, isSelectedHin = false, isSelectedMar = false;

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
    {'name': 'मराठी', 'locale': Locale('mr', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15.0.sp),
            child: Text(
              'Settings'.tr,
              style: TextStyle(
                color: blackColor,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Text(
              'Selected Language'.tr,
              style: TextStyle(
                color: primaryColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Row(
            children: [
              LanguageTile('English'.tr, () {
                updateLanguage(locale[0]['locale']);
                if (isSelectedEng) {
                  setState(() {
                    isSelectedEng = false;
                  });
                } else {
                  setState(() {
                    isSelectedEng = true;
                    isSelectedHin = false;
                    isSelectedMar = false;
                  });
                }
              }, isSelectedEng),
              LanguageTile('Hindi'.tr, () {
                updateLanguage(locale[1]['locale']);
                if (isSelectedHin) {
                  setState(() {
                    isSelectedHin = false;
                  });
                } else {
                  setState(() {
                    isSelectedEng = false;
                    isSelectedHin = true;
                    isSelectedMar = false;
                  });
                }
              }, isSelectedHin),
              LanguageTile('Marathi'.tr, () {
                updateLanguage(locale[2]['locale']);
                if (isSelectedMar) {
                  setState(() {
                    isSelectedMar = false;
                  });
                } else {
                  setState(() {
                    isSelectedEng = false;
                    isSelectedHin = false;
                    isSelectedMar = true;
                  });
                }
              }, isSelectedMar),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Container(
              width: 150.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: secondaryColor,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Icon(
                          Icons.logout,
                          color: whiteColor,
                          size: 20.sp,
                        ),
                      ),
                      Text(
                        'Log Out'.tr,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector LanguageTile(String name, VoidCallback onTap, bool selected) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Container(
          decoration: BoxDecoration(
            color: selected ? primaryColor : secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 15.sp,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
