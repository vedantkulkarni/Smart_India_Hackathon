import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';
import 'package:get/get.dart';
import '../../../../../core/constants.dart';

class AddStudentsPage extends StatefulWidget {
  const AddStudentsPage({Key? key}) : super(key: key);

  @override
  State<AddStudentsPage> createState() => _AddStudentsPageState();
}

class _AddStudentsPageState extends State<AddStudentsPage> {
  Student? _submit() {
    if (_formKey.currentState!.validate()) {
      print(_nameController.text);
      print(_emailController.text);
      print(_phoneController.text);
      print(_addressController.text);
      print(_gender);
      print(_ageController.text);
      print(_rollNoController.text);
      String phNo;
      if (!_phoneController.text.contains('+91')) {
        phNo = '+91${_phoneController.text}';
      } else {
        phNo = _phoneController.text;
      }
      final student = Student(
        studentID: UUID.getUUID(),
        studentName: _nameController.text,
        address: _addressController.text,
        email: _emailController.text,
        phoneNumber: phNo,
        roll: _rollNoController.text,
        classRoomStudentsId: 'blankID',
        gender: _gender,
      );
      print(student);

      _formKey.currentState!.save();
      return student;
    }
    return null;
  }

  Future<List> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    return data["items"];
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  Gender _gender = Gender.Male;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();

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
              padding: EdgeInsets.all(30.sp),
              color: backgroundColor,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: TextFormField(
                              controller: _nameController,
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a name'.tr;
                                }
                                return null;
                              }),
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Name',
                                hintText: 'Enter Your Name',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: TextFormField(
                              controller: _emailController,
                              validator: ((value) {
                                if (value!.isEmpty &&
                                    !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              }),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Email',
                                hintText: 'Enter Your Email',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: TextFormField(
                              controller: _phoneController,
                              validator: ((value) {
                                if (value!.isEmpty || value.length != 10) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              }),
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Phone Number',
                                hintText: 'Enter Your Phone Number',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: TextFormField(
                        controller: _addressController,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        }),
                        decoration: const InputDecoration(
                          fillColor: textFieldFillColor,
                          filled: true,
                          labelStyle: TextStyle(color: primaryColor),
                          labelText: 'Address',
                          hintText: 'Enter Your Address',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: textFieldFillColor,
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: DropdownButton<Gender>(
                              icon: null,
                              iconSize: 24,
                              alignment: Alignment.center,
                              underline: Container(),
                              borderRadius: BorderRadius.circular(10),
                              value: _gender,
                              onChanged: (val) async {
                                // print(val);
                                setState(() {
                                  _gender = val!;
                                });
                              },
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  child: Center(
                                    child: Text(
                                      'Male',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Poppins',
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  value: Gender.Male,
                                ),
                                DropdownMenuItem(
                                  child: Center(
                                    child: Text(
                                      'Female',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Poppins',
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  value: Gender.Female,
                                ),
                                DropdownMenuItem(
                                  child: Center(
                                    child: Text(
                                      'Other',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Poppins',
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  value: Gender.Other,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: TextFormField(
                              controller: _ageController,
                              validator: ((value) {
                                if (value!.isEmpty || value.length >= 4) {
                                  return 'Please enter a valid age';
                                }
                                return null;
                              }),
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Age',
                                hintText: 'Enter Age',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(15.sp),
                            child: TextFormField(
                              controller: _rollNoController,
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please enter roll number';
                                }
                                return null;
                              }),
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Roll number',
                                hintText: 'Enter Roll Number',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(15),
                    //         child: TextFormField(
                    //           controller: _descriptionController,
                    //           validator: ((value) {
                    //             if (value!.isEmpty) {
                    //               return 'Please enter a description';
                    //             }
                    //             return null;
                    //           }),
                    //           decoration: const InputDecoration(
                    //             fillColor: textFieldFillColor,
                    //             filled: true,
                    //             labelStyle: TextStyle(color: primaryColor),
                    //             labelText: 'Description',
                    //             hintText: 'Enter Description',
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width * 0.2,
                    //       padding: const EdgeInsets.all(15),
                    //       child: TextFormField(
                    //         controller: _shiftController,
                    //         validator: ((value) {
                    //           if (value!.isEmpty) {
                    //             return 'Please enter the shift';
                    //           }
                    //           return null;
                    //         }),
                    //         decoration: const InputDecoration(
                    //           fillColor: textFieldFillColor,
                    //           filled: true,
                    //           labelStyle: TextStyle(color: primaryColor),
                    //           labelText: 'Shift',
                    //           hintText: 'Enter the Shift',
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width * 0.10,
                    //       padding:
                    //           const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    //       decoration: BoxDecoration(
                    //         color: textFieldFillColor,
                    //         border: Border.all(color: greyColor, width: 0.5),
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(4),
                    //         ),
                    //       ),
                    //       child: DropdownButton<String>(
                    //           value: dropdownValue,
                    //           underline: Container(),
                    //           elevation: 16,
                    //           style: const TextStyle(color: primaryColor),
                    //           alignment: AlignmentDirectional.centerStart,
                    //           items: <String>[
                    //             'Role',
                    //             'Teacher',
                    //             'Admin',
                    //             'Super Admin'
                    //           ].map<DropdownMenuItem<String>>((String value) {
                    //             return DropdownMenuItem<String>(
                    //               value: value,
                    //               child: Text(value),
                    //             );
                    //           }).toList(),
                    //           onChanged: (String? newVal) {
                    //             setState(() {
                    //               dropdownValue = newVal;
                    //             });
                    //           }),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      width: 150.w,
                      height: 40.h,
                      child: CustomTextButton(
                          onPressed: () async {
                            final student = _submit();
                            if (student != null) {
                              await managementCubit.createStudent(
                                  student: student);
                              Navigator.pop(context);
                            } else {
                              return;
                            }
                          },
                          text: 'Submit'),
                    ),
                    SizedBox(
                      width: 150.w,
                      height: 40.h,
                      child: CustomTextButton(
                          onPressed: () async {
                            List items = await readJson();
                            for (int i = 0; i < items.length; i++) {
                              String phNo = '+91${items[i]["phoneNumber"]}';
                              String gd = items[i]["gender"];
                              Gender gender = Gender.Male;
                              switch (gd) {
                                case "Male":
                                  gender = Gender.Male;
                                  break;
                                case "Female":
                                  gender = Gender.Female;
                                  break;
                                case "Other":
                                  gender = Gender.Other;
                                  break;
                              }
                              final student = Student(
                                studentID: items[i]["studentId"],
                                studentName: items[i]["studentName"],
                                address: items[i]["address"],
                                email: items[i]["email"],
                                phoneNumber: phNo,
                                roll: items[i]["roll"],
                                classRoomStudentsId: items[i]
                                    ["classRoomStudentsId"],
                                gender: gender,
                              );
                              if (student != null) {
                                await managementCubit.createStudent(
                                    student: student);
                              }
                            }
                          },
                          text: 'Submit2'),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
