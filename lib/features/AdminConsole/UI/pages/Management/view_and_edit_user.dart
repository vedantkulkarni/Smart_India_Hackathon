import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';

import '../../../../../models/Role.dart';
import '../../../../../models/User.dart';

class ViewAndEditUser extends StatefulWidget {
  User user;
  Role currentRole;
  ViewAndEditUser({Key? key, required this.user, required this.currentRole})
      : super(key: key);

  @override
  State<ViewAndEditUser> createState() =>
      _ViewAndEditUserState(user, currentRole);
}

class _ViewAndEditUserState extends State<ViewAndEditUser> {
  User user;
  Role currentRole;
  User? _submit() {
    if (_formKey.currentState!.validate()) {
      String phNo;
      print(changedRole);
      if (!_phoneController.text.contains('+91')) {
        phNo = '+91${_phoneController.text}';
      } else {
        phNo = _phoneController.text;
      }
      User updatedUser = user.copyWith(
        name: _fnameController.text + ' ' + _lnameController.text,
        email: _emailController.text,
        phoneNumber: phNo,
        address: _addressController.text,
        description: _descriptionController.text,
        role: changedRole??user.role,
      );
      print(updatedUser.role);
      _formKey.currentState!.save();
      return updatedUser;
    }
    return null;
  }

  _ViewAndEditUserState(
      this.user, this.currentRole); // TODO passing current age
  final _formKey = GlobalKey<FormState>();
  Role? changedRole;
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool canEdit = false;
  @override
  Widget build(BuildContext context) {
    _fnameController.text = user.name.split(' ')[0];
    _lnameController.text = user.name.split(' ')[1];
    _emailController.text = user.email;
    _phoneController.text = user.phoneNumber;
    _addressController.text = user.address ?? 'Unknown';
    _descriptionController.text = user.description ?? 'Unknown';
    Role _dropdownRole = user.role;
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.all(20.sp),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.sp,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          canEdit = true;
                          print(currentRole);
                        });
                      },
                      icon: Icon(
                        fi.FluentIcons.edit,
                        size: 16.sp,
                        color: primaryColor,
                      )),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        final updatedUser = _submit();
                        if (updatedUser != null) {
                          await managementCubit.updateUser(
                              updatedUser: updatedUser);
                          Navigator.pop(context);
                        } else {
                          return;
                        }
                      },
                      icon: Icon(
                        fi.FluentIcons.check_mark,
                        size: 20.sp,
                        color: primaryColor,
                      )),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150.h,
                  width: 150.w,
                  child: const CircleAvatar(
                    backgroundColor: textFieldFillColor,
                    child: Center(child: Icon(fi.FluentIcons.photo2_add)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.gender ?? 'Unknown',
    
                    style: TextStyle(
                        color: greyColor, fontFamily: 'Poppins',fontSize:14.sp),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text('|',
                      style: TextStyle(
                          color: primaryColor, fontFamily: 'Poppins',fontSize:14.sp)),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(user.age == null ? 'Unknown' : user.age.toString(),
                      style: TextStyle(
                          color: greyColor, fontFamily: 'Poppins',fontSize:14.sp)),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text('|',
                      style: TextStyle(
                          color: primaryColor, fontFamily: 'Poppins',fontSize:14.sp)),
                  SizedBox(
                    width: 10.w,
                  ),
                  DropdownButton<Role>(
                    icon: null,
                    iconSize: 0.0,
                    alignment: Alignment.center,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(10),
                    value: _dropdownRole,
                    onChanged: (value) {
                      setState(() {
                        user = user.copyWith(role: value);
                        _dropdownRole = value!; // TODO bugged
                        changedRole = value;
                      });

                      // changeRole(value!);
                      print(_dropdownRole);
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text('Super Admin',
                            style: TextStyle(
                                color: greyColor,
                                fontFamily: 'Poppins',
                                fontSize: 14.sp)),
                        value: Role.SuperAdmin,
                      ),
                      DropdownMenuItem(
                          child: Text('Admin',
                              style: TextStyle(
                                  color: greyColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp)),
                          value: Role.Admin),
                      DropdownMenuItem(
                          child: Text('Teacher',
                              style: TextStyle(
                                  color: greyColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp)),
                          value: Role.Teacher)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      enabled: canEdit,
                      hintText: user.name.trim().split(' ')[0],
                      padding: EdgeInsets.all(5.sp),
                      heading: 'First Name',
                      textEditingController: _fnameController,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomTextField(
                      enabled: canEdit,
                      hintText: user.name.trim().split(' ')[1],
                      padding: EdgeInsets.all(5.sp),
                      heading: 'Last Name',
                      textEditingController: _lnameController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      enabled: canEdit,
                      hintText: user.email,
                      padding: EdgeInsets.all(5.sp),
                      heading: 'Email',
                      textEditingController: _emailController,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: CustomTextField(
                      enabled: canEdit,
                      hintText: user.phoneNumber,
                      padding: EdgeInsets.all(5.sp),
                      heading: 'Phone Number',
                      textEditingController: _phoneController,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                enabled: canEdit,
                hintText: user.address ?? 'Unknown',
                padding: EdgeInsets.all(5.sp),
                heading: 'Address',
                textEditingController: _addressController,
              ),
              CustomTextField(
                enabled: canEdit,
                hintText: user.description ?? 'Unknown',
                padding: EdgeInsets.all(5.sp),
                heading: 'Description',
                textEditingController: _descriptionController,
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextButton(
                    onPressed: () async {
                      await managementCubit.deleteUser(email: user.email);
                      await managementCubit.getAllUsers(role: currentRole,); //TODO static
                      Navigator.pop(context, true);
                    },
                    text: 'Delete',
                    bgColor: redColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeRole(Role role) {
    print(role);
    setState(() {
      user = user.copyWith(role: role);
    });
  }
}
