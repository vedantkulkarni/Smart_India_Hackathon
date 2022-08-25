import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/management_card.dart';
import 'package:get/get.dart';
import '../../../../core/constants.dart';

class Management extends StatefulWidget {
  const Management({Key? key}) : super(key: key);

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  final List<List<String>> addList = [
    [
      'User',
      'View, manage, update, create and delete users.',
      '$commonPath/user.png'
    ],
    [
      'Students'.tr,
      'View, manage, update, create and delete students',
      '$commonPath/students.png'
    ],
    [
      'Groups'.tr,
      'View, manage, update, create and delete groups',
      '$commonPath/box.png'
    ],
    [
      'ClassRoom'.tr,
      'View, manage, update, create and delete classroom',
      '$commonPath/myClassRoom.png'
    ],
    [
      'Attendance'.tr,
      'View, manage, update, download and delete student\'s attendance',
      '$commonPath/attendance.png'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Management".tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                fontFamily: 'Poppins',
                color: Colors.black),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              2,
             (index) => ManageMentCard(
                addText: addList[index][0].tr,
                content: addList[index][1],
                imagePath: addList[index][2],
                index: index,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => ManageMentCard(
                addText: addList[index + 2][0],
                content: addList[index + 2][1],
                imagePath: addList[index + 2][2],
                index: index + 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
