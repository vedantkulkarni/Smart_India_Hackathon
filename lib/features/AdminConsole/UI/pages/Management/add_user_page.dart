import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../../../core/constants.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  User? _submit1() {
    if (_formKey.currentState!.validate()) {
      print(_nameController.text);
      print(_emailController.text);
      print(_phoneController.text);
      print(_addressController.text);
      print(_genderController.text);
      print(_ageController.text);
      print(_classController.text);
      print(_descriptionController.text);
      print(_shiftController.text);
      String phNo;
      phNo = '+91${_phoneController.text}';
      final user = User(
        id: UUID.getUUID(),
        email: _emailController.text,
        name: _nameController.text,
        description: _descriptionController.text,
        role: Role.Teacher,
        phoneNumber: phNo,
        address: _addressController.text,
        shitfInfo: _shiftController.text,
        gender: _genderController.text,
        age: int.parse(_ageController.text),
      );
      _formKey.currentState!.save();

      return user;
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  Role _role = Role.SuperAdmin;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _shiftController = TextEditingController();
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
            if (state is AddingUser) {
              return progressIndicator;
            }

            return Container(
              padding: const EdgeInsets.all(30),
              color: backgroundColor,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              controller: _nameController,
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a name';
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
                            padding: const EdgeInsets.all(15),
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
                            padding: const EdgeInsets.all(15),
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
                      padding: const EdgeInsets.all(15),
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
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              controller: _genderController,
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a gender';
                                }
                                return null;
                              }),
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Gender',
                                hintText: 'Enter Your Gender',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
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
                                hintText: 'Enter Your Age',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              controller: _classController,
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a class';
                                }
                              }),
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Assigned Class',
                                hintText: 'Enter Your Assigned Class',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              controller: _descriptionController,
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a description';
                                }
                                return null;
                              }),
                              decoration: const InputDecoration(
                                fillColor: textFieldFillColor,
                                filled: true,
                                labelStyle: TextStyle(color: primaryColor),
                                labelText: 'Description',
                                hintText: 'Enter Description',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: const EdgeInsets.all(15),
                          child: TextFormField(
                            controller: _shiftController,
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Please enter the shift';
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                              fillColor: textFieldFillColor,
                              filled: true,
                              labelStyle: TextStyle(color: primaryColor),
                              labelText: 'Shift',
                              hintText: 'Enter the Shift',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.10,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 4),
                          decoration: BoxDecoration(
                            color: textFieldFillColor,
                            border: Border.all(color: greyColor, width: 0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: DropdownButton<Role>(
                            value: _role,
                            onChanged: (val) {
                              setState(() {
                                _role = val!;
                              });
                            },
                            underline: Container(),
                            elevation: 16,
                            style: const TextStyle(color: primaryColor),
                            alignment: AlignmentDirectional.centerStart,
                            items: const [
                              DropdownMenuItem<Role>(
                                value: Role.SuperAdmin,
                                child: Text('Super Admin'),
                              ),
                              DropdownMenuItem<Role>(
                                value: Role.Admin,
                                child: Text('Admin'),
                              ),
                              DropdownMenuItem<Role>(
                                child: Text('Techer'),
                                value: Role.Teacher,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: 150,
                        height: 40,
                        child: CustomTextButton(
                            onPressed: () async {
                              final user = _submit1();
                              if (user != null) {
                                await managementCubit.addNewUser(newUser: user);
                                Navigator.pop(context);
                              } else {
                                return;
                              }
                            },
                            text: 'Submit'),
                      ),
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
