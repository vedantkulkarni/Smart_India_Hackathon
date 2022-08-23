import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/manage_attendance_page.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/manage_classrooms_page.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/manage_leaves.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/manage_students_page.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/manage_users_page.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

class ManageMentCard extends StatelessWidget {
  final String addText;
  final String content;
  final String imagePath;
  final int index;
  ManageMentCard(
      {Key? key,
      required this.addText,
      required this.content,
      required this.imagePath,
      required this.index})
      : super(key: key);
  List<ManagementMode> modes = [
    ManagementMode.User,
    ManagementMode.Students,
    ManagementMode.Leaves,
    ManagementMode.ClassRooms,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return MultiBlocProvider(providers: [
                BlocProvider.value(value: BlocProvider.of<AdminCubit>(context)),
                BlocProvider(
                    create: (context) => ManagementCubit(
                        awsApiClient: getIt<AWSApiClient>(),
                        managementMode: modes[index])),
              ], child: customPushHandlerFunction(index));
            }));
          },
          child: Container(
              height: 200.h,
              width: 200.w,
              margin:  EdgeInsets.symmetric(horizontal: 10.w),
              padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
                ],
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: Image.asset(imagePath),
                  ),
                   SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    addText,
                    style:  TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 18.sp),
                  ),
                   Text(
                    content,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: lightTextColor,
                        fontFamily: 'Poppins',
                        fontSize: 14.sp),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget customPushHandlerFunction(int index) {
    if (index == 0) {
      return const ManageUsers();
    } else if (index == 1) {
      return const ManageStudentsPage();
    } else if (index == 2) {
      //manage groups
      return const ManageLeaves();
    } else if (index == 3) {
      return const ManageClassroom();
    } else {
      //Attendacnce
      print(index);
      return const ManageAttendancePage();
    }
  }
}
