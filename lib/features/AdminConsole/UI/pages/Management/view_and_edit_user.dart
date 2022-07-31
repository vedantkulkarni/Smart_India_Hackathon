import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';

import '../../../../../models/Role.dart';
import '../../../../../models/User.dart';

class ViewAndEditUser extends StatefulWidget {
  User user;
  ViewAndEditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewAndEditUser> createState() => _ViewAndEditUserState(user);
}

class _ViewAndEditUserState extends State<ViewAndEditUser> {
  User user;
  _ViewAndEditUserState(this.user);
  bool canEdit = false;
  @override
  Widget build(BuildContext context) {
    final managementCubit = BlocProvider.of<ManagementCubit>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        canEdit = true;
                      });
                    },
                    icon: const Icon(
                      fi.FluentIcons.edit,
                      size: 16,
                      color: primaryColor,
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      fi.FluentIcons.check_mark,
                      size: 20,
                      color: primaryColor,
                    )),
              ],
            ),
            const Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundColor: textFieldFillColor,
                  child: Center(child: Icon(fi.FluentIcons.photo2_add)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                user.gender ?? 'Unknown',
                style: const TextStyle(color: greyColor, fontFamily: 'Poppins'),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('|',
                  style: TextStyle(color: primaryColor, fontFamily: 'Poppins')),
              const SizedBox(
                width: 10,
              ),
              Text(user.age == null ? 'Unknown' : user.age.toString(),
                  style:
                      const TextStyle(color: greyColor, fontFamily: 'Poppins')),
              const SizedBox(
                width: 10,
              ),
              const Text('|',
                  style: TextStyle(color: primaryColor, fontFamily: 'Poppins')),
              const SizedBox(
                width: 10,
              ),
              DropdownButton<Role>(
                icon: null,
                iconSize: 0.0,
                alignment: Alignment.center,
                underline: Container(),
                borderRadius: fi.BorderRadius.circular(10),
                value: user.role,
                onChanged: (value) {
                  changeRole(value!);
                  print(user.role);
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('SuperAdmin',
                        style: TextStyle(
                            color: greyColor,
                            fontFamily: 'Poppins',
                            fontSize: 14)),
                    value: Role.SuperAdmin,
                  ),
                  DropdownMenuItem(
                      child: Text('Admin',
                          style: TextStyle(
                              color: greyColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: Role.Admin),
                  DropdownMenuItem(
                      child: Text('Teacher',
                          style: TextStyle(
                              color: greyColor,
                              fontFamily: 'Poppins',
                              fontSize: 14)),
                      value: Role.Teacher)
                ],
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    enabled: canEdit,
                    value: user.name.trim().split(' ')[0],
                    hintText: user.name.trim().split(' ')[0],
                    padding: const EdgeInsets.all(5),
                    heading: 'First Name',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextField(
                    enabled: canEdit,
                    hintText: user.name.trim().split(' ')[1],
                    value: user.name.trim().split(' ')[1],
                    padding: const EdgeInsets.all(5),
                    heading: 'Last Name',
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
                    value: user.email,
                    padding: const EdgeInsets.all(5),
                    heading: 'Email',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomTextField(
                    enabled: canEdit,
                    hintText: user.phoneNumber,
                    value: user.phoneNumber,
                    padding: const EdgeInsets.all(5),
                    heading: 'Phone Number',
                  ),
                ),
              ],
            ),
            CustomTextField(
              enabled: canEdit,
              hintText: user.address ?? 'Unknown',
              value: user.address ?? 'Unknown',
              padding: const EdgeInsets.all(5),
              heading: 'Address',
            ),
            CustomTextField(
              enabled: canEdit,
              hintText: user.description ?? 'Unknown',
              value: user.description ?? 'Unknown',
              padding: const EdgeInsets.all(5),
              heading: 'Description',
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextButton(
                  onPressed: () async {
                    await managementCubit.deleteUser(email: user.email);
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
    );
  }

  void changeRole(Role role) {
    print(role);
    setState(() {
      user = user.copyWith(role: role);
    });
  }
}
