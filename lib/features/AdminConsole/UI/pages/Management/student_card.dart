import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/class_details_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_dialog_box.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import '../../../../../core/constants.dart';
import '../../../../../models/Student.dart';

class StudentCard extends StatelessWidget {
  Student student;
  VoidCallback onTap;
  StudentCard({Key? key, required this.student,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final classCubit = BlocProvider.of<ClassDetailsCubit>(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: textFieldFillColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  student.profilePhoto ??
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600',
                ),
                radius: 20,
              ),
              FittedBox(
                child: Text(student.studentName.trim().split(' ')[0],
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 14.sp)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StudentCardDetails extends StatefulWidget {
  Student student;
  StudentCardDetails({Key? key, required this.student}) : super(key: key);

  @override
  State<StudentCardDetails> createState() => _StudentCardDetailsState(student);
}

class _StudentCardDetailsState extends State<StudentCardDetails> {
  Student student;
  _StudentCardDetailsState(this.student);
  @override
  Widget build(BuildContext context) {
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Container(
      child: Column(
        children: [
          CustomTextButton(
              onPressed: () async {
                final updatedStudent =
                    student.copyWith(classRoomStudentsId: null);
                await managementCubit.updateStudent(
                    updatedStudent: updatedStudent);
                print("Student updated");
                Navigator.pop(context, true);
              },
              text: 'Remove from this class'),
          CustomTextButton(
              onPressed: () {}, text: 'Assign to a different class'),
          CustomTextButton(onPressed: () {}, text: 'View in student management')
        ],
      ),
    );
  }
}
