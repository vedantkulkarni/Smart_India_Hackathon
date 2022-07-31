import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';

import '../../../../../models/User.dart';

class TeacherDetailsPage extends StatefulWidget {
  User user;
  TeacherDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<TeacherDetailsPage> createState() => _TeacherDetailsPageState(user);
}

class _TeacherDetailsPageState extends State<TeacherDetailsPage> {
  User teacher;
  _TeacherDetailsPageState(this.teacher);
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
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  fi.FluentIcons.edit,
                  size: 16,
                  color: primaryColor,
                )),
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
                teacher.gender ?? 'Unknown',
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
              Text(teacher.age == null ? 'Unknown' : teacher.age.toString(),
                  style:
                      const TextStyle(color: greyColor, fontFamily: 'Poppins'))
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    enabled: canEdit,
                    value: teacher.name.trim().split(' ')[0],
                    hintText: teacher.name.trim().split(' ')[0],
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
                    hintText: teacher.name.trim().split(' ')[1],
                    value: teacher.name.trim().split(' ')[1],
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
                    hintText: teacher.email,
                    value: teacher.email,
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
                    hintText: teacher.phoneNumber,
                    value: teacher.phoneNumber,
                    padding: const EdgeInsets.all(5),
                    heading: 'Phone Number',
                  ),
                ),
              ],
            ),
            CustomTextField(
              enabled: canEdit,
              hintText: teacher.address ?? 'Unknown',
              value: teacher.address ?? 'Unknown',
              padding: const EdgeInsets.all(5),
              heading: 'Address',
            ),
            CustomTextField(
              enabled: canEdit,
              hintText: teacher.description ?? 'Unknown',
              value: teacher.description ?? 'Unknown',
              padding: const EdgeInsets.all(5),
              heading: 'Description',
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextButton(
                  onPressed: () async {
                    await managementCubit.deleteTeacher(email: teacher.email);
                    Navigator.pop(context,true);
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
}
