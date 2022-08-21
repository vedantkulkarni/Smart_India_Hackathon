import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import '../../../../../core/constants.dart';

class ManageAttendancePage extends StatefulWidget {
  const ManageAttendancePage({Key? key}) : super(key: key);

  @override
  State<ManageAttendancePage> createState() => _ManageAttendancePageState();
}

class _ManageAttendancePageState extends State<ManageAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Container()],
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body: Container(
        child: Row(children: const [AttendanceWidget()]),
      ),
    );
  }
}

class AttendanceWidget extends StatefulWidget {
  const AttendanceWidget({Key? key}) : super(key: key);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 250.h,
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //     colors: whiteColor,
          //     begin: Alignment.bottomLeft,
          //     end: Alignment.topRight),
          color: whiteColor,
          boxShadow: const [
            BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
          ],

          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: primaryColor,
                      child: CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                            "https://image.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-260nw-1836020740.jpg"),
                      ),
                    ),
                  ),
                  Text(
                    'Harsh',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: blackColor),
                  )
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 100.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: primaryColor),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Id Card',
                            style: TextStyle(
                              color: whiteColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 100.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: primaryColor),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'CSV',
                            style: TextStyle(
                              color: whiteColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 100.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: primaryColor),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Assign New Class',
                            style: TextStyle(
                              color: whiteColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const Divider(
            color: blackColor,
            height: 10,
          ),
          Col1Widget()
        ]),
      ),
    );
  }
}

Container Col1Widget() {
  return Container(
    height: 250.h,
    width: 400.w,
    decoration: const BoxDecoration(
      // border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.all(Radius.circular(10)),

      color: backgroundColor,
    ),
    child: Column(children: [
      Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Attendance log',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 15.sp, color: blackColor),
        ),
      ),
      Expanded(
        child: DataTable2(
            empty: Container(
                child: const Center(
              child: Text('No Students added yet'),
            )),
            dataTextStyle: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: blackColor),
            headingTextStyle: TextStyle(
                fontSize: 16.sp,
                color: blackColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
            columns: const [
              DataColumn2(
                label: Text(
                  'Sr No',
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text(
                  'Date',
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text(
                  'Present/Absent',
                ),
                size: ColumnSize.L,
              ),
            ],
            rows: const []),
      )
    ]),
  );
}
