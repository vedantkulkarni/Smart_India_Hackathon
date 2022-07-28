import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textfield.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../Backend/admin_bloc/admin_cubit.dart';

class CreateSchoolPage extends StatefulWidget {
  const CreateSchoolPage({Key? key}) : super(key: key);

  @override
  State<CreateSchoolPage> createState() => _CreateSchoolPageState();
}

class _CreateSchoolPageState extends State<CreateSchoolPage> {
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
            const CustomTextField(
                hintText: 'School Name',
                labelText: 'Give a name to your school',
                padding: EdgeInsets.all(20)),
            const CustomTextField(
                hintText: 'Address',
                labelText: 'Address',
                padding: EdgeInsets.all(20)),
            const CustomTextField(
                hintText: 'Contance Phone',
                labelText: 'Contact',
                padding: EdgeInsets.all(20)),
            const CustomTextField(
                hintText: 'Contact email',
                labelText: 'email',
                padding: EdgeInsets.all(20)),
            const CustomTextField(
                hintText: 'location',
                labelText: 'loaction google maps link',
                padding: EdgeInsets.all(20)),
            const SizedBox(
              height: 60,
            ),
            CustomTextButton(
                onPressed: () async {
                  print(adminCubit.adminID);
                  final school = School(
                      superAdmin: adminCubit.adminID,
                      schoolName: 'School Name',
                      schoolID: 'school id',
                      contactEmail: 'vedantk60@gmail.com',
                      contactPhone: '+91 9623026654',
                      address: 'some address',
                      location:
                          'https://docs.aws.amazon.com/appsync/latest/devguide/scalars.html');

                  await adminCubit.createSchool(school: school);
                  Navigator.pop(context);
                },
                text: 'Submit')
          ],
        ),
      ),
    );
  }
}
