import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';

import '../../../../models/ClassRoom.dart';
import '../../../../models/VerificationStatus.dart';
import 'custom_textbutton.dart';
import 'custom_textfield.dart';

class CreateClassRoom extends StatefulWidget {
  const CreateClassRoom({Key? key}) : super(key: key);

  @override
  State<CreateClassRoom> createState() => _CreateClassRoomState();
}

class _CreateClassRoomState extends State<CreateClassRoom> {
  @override
  Widget build(BuildContext context) {
    final adminCubit = BlocProvider.of<AdminCubit>(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            CustomTextField(
                hintText: 'Class Name', padding: const EdgeInsets.all(20)),
            CustomTextField(
                hintText: 'Address', padding: const EdgeInsets.all(20)),
            CustomTextField(
                hintText: 'Contance Phone', padding: const EdgeInsets.all(20)),
            CustomTextField(
                hintText: 'Contact email', padding: const EdgeInsets.all(20)),
            CustomTextField(
                hintText: 'location', padding: const EdgeInsets.all(20)),
            const SizedBox(
              height: 60,
            ),
            CustomTextButton(
                onPressed: () async {
                  print("Hello : ${adminCubit.school.schoolID}");
                  final classRoom = ClassRoom(
                    schoolID: adminCubit.school.schoolID,
                    attendanceMode: VerificationStatus.ManualAttendance,
                    classRoomName: 'Some classRoom Name',
                  );

                  await adminCubit.createClassRoom(classRoom: classRoom);
                  Navigator.pop(context);
                },
                text: 'Submit')
          ],
        ),
      ),
    );
  }
}
