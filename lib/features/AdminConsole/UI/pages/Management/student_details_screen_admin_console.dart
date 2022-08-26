import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/class_details_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/student_details_cubit_cubit.dart';

import '../../../../../injection_container.dart';
import '../../../../../models/Attendance.dart';
import '../../../../TeacherConsole/widgets/future_image.dart';

class StudentDetailScreenPartAdmin extends StatefulWidget {
  final String studentId = "";
  const StudentDetailScreenPartAdmin({Key? key, required String studentId})
      : super(key: key);

  @override
  State<StudentDetailScreenPartAdmin> createState() =>
      _StudentDetailScreenPart();
}

class _StudentDetailScreenPart extends State<StudentDetailScreenPartAdmin> {
  List<Attendance> studentAttendanceList = [];
  List<int> srNo = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30
  ];
  Future<void> getStudentAnalytics(String studentId) async {
    print('start');
    var apiclient = getIt<AWSApiClient>();
    studentAttendanceList =
        await apiclient.getStudentAnalytics(studentId: '3787c22e-f195-4e0c-a2d3-72c16ab6160e', month: '08');

    setState(() {

    });
    print(studentAttendanceList);
  
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudentAnalytics(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    final studentDetailsCubit =
        BlocProvider.of<StudentDetailsCubitCubit>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: Text(
          'Student Profile',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: blackColor),
        ),
      ),
      body: BlocBuilder<StudentDetailsCubitCubit, StudentDetailsCubitState>(
        builder: (context, state) {
          if (state is FetchingStudentDetails) return progressIndicator;
          return Row(children: [
            Expanded(
                child: StudentDetailWidget(
              name: studentDetailsCubit.studentDeatail!.studentName.toString(),
              image: studentDetailsCubit.studentDeatail!.profilePhoto,
              teacherName:
                  studentDetailsCubit.studentDeatail!.roll.toString(),
              email: studentDetailsCubit.studentDeatail!.email.toString(),
              phoneNumber:
                  studentDetailsCubit.studentDeatail!.phoneNumber.toString(),
              classname: BlocProvider.of<ClassDetailsCubit>(context)
                  .classRoom
                  .classRoomName.toString(),
            )),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Col1Widget(),
                  )),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Col2Widget(),
                  )),
                ],
              ),
            )
          ]);
        },
      ),
    );
  }

  Container Col1Widget() {
    return Container(
      // height: 250,
      // width: 400,
      decoration: const BoxDecoration(
        // border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10),
        ],
        color: backgroundColor,
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10),
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
              rows: List<DataRow>.generate(
                  studentAttendanceList.length,
                  (index) => DataRow2.byIndex(
                          selected: true,
                          color: MaterialStateProperty.all(whiteColor),
                          index: index,
                          cells: [
                            DataCell(Text(srNo[index].toString())),
                            DataCell(Text(srNo[index].toString())),
                            DataCell(Text(studentAttendanceList[index].status.name)),
                          ]))),
        )
      ]),
    );
  }
}

class Col2Widget extends StatelessWidget {
  const Col2Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 250,
      // width: 400,
      decoration: const BoxDecoration(
        //border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10),
        ],
        color: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Id card',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.sp,
                      color: blackColor),
                ),
              ),
              Container(
                height: 150.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 200.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                'CSV ',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15.sp,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 20.sp,
                          )
                        ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Assign to \n new class',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.white),
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
    );
  }
}

class StudentDetailWidget extends StatelessWidget {
  final String? name, email, phoneNumber, classname, teacherName,image;
  const StudentDetailWidget({
    Key? key,
    required this.classname,
    required this.image,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.teacherName,
    //required this.profileName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.all(25.sp),
      child: Container(
       // height: 700.h,
        width: 400.w,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10),
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          Container(child: FutureImage(imageKey: image),height:80.h,width:80.w,),
          SizedBox(
            height: 50.h,
          ),
          RowWidget('Name', name.toString()),
          RowWidget('Email', email.toString()),
          RowWidget('Phone No.', phoneNumber.toString()),
          RowWidget('Class', classname.toString()),
          RowWidget('Teacher', teacherName.toString()),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15.sp,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15.sp,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Padding RowWidget(String title, String field) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        children: [
          Text(
            '$title : - ',
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 17.sp, color: blackColor),
          ),
          Text(
            field,
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 17.sp, color: blackColor),
          ),
        ],
      ),
    );
  }
}
