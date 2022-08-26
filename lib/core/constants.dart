//all color schemes and constants in the app.

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const Color primaryColor = Color(0xff3fc47c);
// const Color primaryColor = Colors.blue;
const Color secondaryColor = Color(0xffaee8ae);
const Color backgroundColor = Color(0xffffffff);
const Color sideMenubg = Color(0xfffdfdff);
const Color whiteColor = Color(0xffffffff);
const Color greyColor = Color(0xffb4bbc6);
const Color blendColor = Color(0xfff3f3f3);
const Color navPanecolor = Color(0xfffdfdff);
const Color navIconsColor = Color(0xff919caa);
const Color blackColor = Color(0xff1b1e22);
const Color redColor = Color(0xffff313a);
const Color yellowColor = Color(0xffFFFF00);

const Color textFieldFillColor = Color(0xfff6f6fc);
const Color lightTextColor = Color(0xff9aa3b1);

Widget progressIndicator = Container(
  color: backgroundColor,
  child: Center(
    child: SizedBox(
      height: 50,
      width: 50,
      child:
          Center(child: Lottie.asset("assets/images/loader.json", animate: true)),
    ),
  ),
);

String sharedPrefKey = 'classAttendancesList';

//role check conditions
enum UserRole { CanCreateSchool }

enum ManagementMode { Teachers, Students, User, ClassRooms, Leaves }

enum SearchMode { Attendance, Student }

enum StudentSearchMode { name, roll, email, studentID }

enum AttendanceSearchMode {
  date,
  status,
  className,
  teacherID,
  teacherName,
  studentName,
  verification,
  classID,
  gender
}

enum ClassRoomCompareMode { gender, attendance, overall}

const String commonPath = 'assets/images';
