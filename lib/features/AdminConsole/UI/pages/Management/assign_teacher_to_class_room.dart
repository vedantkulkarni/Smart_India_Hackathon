import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/user_profile_card.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../../core/constants.dart';
import '../../../../../models/User.dart';
import '../../widgets/custom_textbutton.dart';
import '../../widgets/custom_textfield.dart';

class AssignTeacherToClassRoom extends StatefulWidget {
  ClassRoom classRoom;
  AssignTeacherToClassRoom({Key? key, required this.classRoom})
      : super(key: key);

  @override
  State<AssignTeacherToClassRoom> createState() =>
      _AssignTeacherToClassRoomState();
}

class _AssignTeacherToClassRoomState extends State<AssignTeacherToClassRoom> {
  User? teacher;
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context, designSize: Size(width, height));
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
           SizedBox(
            height: 40.h,
          ),
          Container(
            margin: EdgeInsets.all(10.sp),
            child: CustomTextField(
              textEditingController: textEditingController,
              hintText: 'Search',
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              width: 300.w,
              prefixIcon: Icon(
                Icons.search,
                size: 14.sp,
              ),
            ),
          ),
          teacher == null
              ? Container()
              : Expanded(
                  child: Container(
                    child: UserProfileCard(user: teacher!),
                  ),
                ),
          Container(
              child: Center(
            child: CustomTextButton(
              onPressed: () async {
                final searchedTeacher = await managementCubit.getUser(
                    userID: textEditingController.text);
                setState(() {
                  teacher = searchedTeacher;
                });
              },
              text: 'Search',
            ),
          )),
          Container(
              child: Center(
            child: CustomTextButton(
              onPressed: () async {
                if (teacher == null) return;

                final updateClassRoom = widget.classRoom
                    .copyWith(userAssignedClassId: teacher!.email);
                final result = await managementCubit.updateClassRoom(
                    updatedClassRoom: updateClassRoom);
                Navigator.pop(context, true);
              },
              text: 'Assign',
            ),
          ))
        ],
      ),
    );
  }
}
