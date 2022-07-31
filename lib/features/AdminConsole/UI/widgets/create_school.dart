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
             CustomTextField(
                hintText: 'School Name',
               
                padding: EdgeInsets.all(20)),
             CustomTextField(
                hintText: 'Address',
                
                padding: EdgeInsets.all(20)),
             CustomTextField(
                hintText: 'Contance Phone',
                
                padding: EdgeInsets.all(20)),
             CustomTextField(
                hintText: 'Contact email',
                
                padding: EdgeInsets.all(20)),
             CustomTextField(
                hintText: 'location',
                
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
