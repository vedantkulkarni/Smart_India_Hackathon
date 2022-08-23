import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../../../core/constants.dart';

class CreateClassRoom extends StatefulWidget {
  const CreateClassRoom({Key? key}) : super(key: key);

  @override
  State<CreateClassRoom> createState() => _CreateClassRoomState();
}

class _CreateClassRoomState extends State<CreateClassRoom> {
  ClassRoom? _submit({required String schoolID}) {
    if (_formKey.currentState!.validate()) {
      print(_nameController.text);

      print(_addressController.text);

      final classroom = ClassRoom(
          schoolID: schoolID,
          classRoomName: _nameController.text,
          attendanceMode: mode,
          schoolClassRoomsId: schoolID,
          userAssignedClassId: _assignedTeacherController.text,
          );

      print(classroom);
      _formKey.currentState!.save();
      return classroom;
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _assignedTeacherController =
      TextEditingController();

  VerificationStatus mode = VerificationStatus.ManualAttendance;

  @override
  Widget build(BuildContext context) {
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    final adminCubit = BlocProvider.of<AdminCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: navIconsColor),
      ),
      body: Container(
        color: backgroundColor,
        child: BlocBuilder<ManagementCubit, ManagementState>(
          builder: (context, state) {
            if (state is AddingStudent) {
              return progressIndicator;
            }

            return Container(
                padding: const EdgeInsets.all(30),
                color: backgroundColor,
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              controller: _nameController,
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a name for your Classroom';
                                }
                                return null;
                              }),
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Classroom name',
                                hintText: 'Classroom name',
                              ),
                            ),
                          ),
                        ),

                        
                      ],
                    ),
                    
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: _assignedTeacherController,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Please enter email address of assigned teacher';
                            }
                            return null;
                          }),
                          decoration: const InputDecoration(
                            fillColor: textFieldFillColor,
                            filled: true,
                            labelStyle: TextStyle(color: primaryColor),
                            labelText: 'Assigned Teacher Email',
                            hintText: 'Assigned Teacher Email',
                          ),
                        ),
                      ),
                    ),
                     DropdownButton<VerificationStatus>(
                icon: null,
                iconSize: 14.sp,
                alignment: Alignment.center,
                underline: Container(),
                borderRadius: BorderRadius.circular(10),
                value: mode,
                onChanged: (value) async {
                  // managementCubit.clearUserList();
                  
                  

                  setState(() {
                    mode = value!;
                  });
                  // managementCubit.getAllUsers(role: value);
                },
                items:  [
                  DropdownMenuItem(
                    child: Text('FaceDetectedAndVerified',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14.sp)),
                    value: VerificationStatus.FaceDetectedAndVerified,
                  ),
                  DropdownMenuItem(
                      child: Text('FaceVerified',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: VerificationStatus.FaceVerified),
                  DropdownMenuItem(
                      child: Text('FaceVerifiedWithLiveness',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: VerificationStatus.FaceVerifiedWithLiveness),
                  DropdownMenuItem(
                      child: Text('ManualAttendance',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: VerificationStatus.ManualAttendance),
                  DropdownMenuItem(
                      child: Text('InvolveParent',
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14.sp)),
                      value: VerificationStatus.InvolveParent),
                ],
              ),
                     SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                        width: 150.w,
                        height: 40.h,
                        child: CustomTextButton(
                            onPressed: () async {
                              var schoolID =
                                  BlocProvider.of<AdminCubit>(context)
                                      .school
                                      .schoolID;
                              final classRoom = _submit(schoolID: schoolID);
                              if (classRoom != null) {
                                await managementCubit.createClassRoom(
                                    classRoom: classRoom);
                                Navigator.pop(context,classRoom);
                              } else {
                                // return;
                              }
                            },
                            text: 'Submit'))
                  ]),
                ));
          },
        ),
      ),
    );
  }
}
