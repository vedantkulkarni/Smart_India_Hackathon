import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

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
                hintText: 'Class Name',
                labelText: 'Give a name to your school',
                padding: EdgeInsets.all(20)),
             CustomTextField(
                hintText: 'Address',
                labelText: 'Address',
                padding: EdgeInsets.all(20)),
             CustomTextField(
                hintText: 'Contance Phone',
                labelText: 'Contact',
                padding: EdgeInsets.all(20)),
             CustomTextField(
                hintText: 'Contact email',
                labelText: 'email',
                padding: EdgeInsets.all(20)),
             CustomTextField(
                hintText: 'location',
                labelText: 'loaction google maps link',
                padding: EdgeInsets.all(20)),
            const SizedBox(
              height: 60,
            ),
            CustomTextButton(
                onPressed: () async {
                  final classRoom = ClassRoom(
                    schoolID: adminCubit.school.schoolID,
                    classRoomID: 'Some classRoom Id',
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
