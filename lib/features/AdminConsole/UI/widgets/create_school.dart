import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _schoolAddressController =
      TextEditingController();
  final TextEditingController _schoolPhoneController = TextEditingController();
  final TextEditingController _schoolEmailController = TextEditingController();
  final TextEditingController _schoolLocationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final adminCubit = BlocProvider.of<AdminCubit>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              CustomTextField(
                  hintText: 'School Name',

                  textEditingController: _schoolNameController,
                  padding: EdgeInsets.all(20)),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                  hintText: 'Address',
                  textEditingController: _schoolAddressController,
                  padding: EdgeInsets.all(20)),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        hintText: 'Contact Phone',
                        textEditingController: _schoolPhoneController,
                        padding: EdgeInsets.all(20)),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: CustomTextField(
                        hintText: 'Contact email',
                        textEditingController: _schoolEmailController,
                        padding: EdgeInsets.all(20)),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                  hintText: 'location',
                  textEditingController: _schoolLocationController,
                  padding: EdgeInsets.all(20)),
              SizedBox(
                height: 60.h,
              ),
              Container(
                width: 200.w,
                height: 50.h,
                child: CustomTextButton(
                  
                    onPressed: () async {
                      print(adminCubit.adminID);
                      final school = School(
                          superAdmin: adminCubit.adminID,
                          schoolName: _schoolNameController.text,
                          schoolID: 'school id',
                          contactEmail: _schoolEmailController.text,
                          contactPhone: _schoolPhoneController.text,
                          address: _schoolAddressController.text,
                          location:
                              'https://docs.aws.amazon.com/appsync/latest/devguide/scalars.html');

                      await adminCubit.createSchool(school: school);
                      Navigator.pop(context);
                    },
                    text: 'Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
