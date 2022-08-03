import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../../../core/constants.dart';

class AddStudentsPage extends StatefulWidget {
  const AddStudentsPage({Key? key}) : super(key: key);

  @override
  State<AddStudentsPage> createState() => _AddStudentsPageState();
}

class _AddStudentsPageState extends State<AddStudentsPage> {
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

            return Center(
              child: CustomTextButton(
                onPressed: () async {
                  //Create Student in DB
                  final student = Student(
                    studentID: 'someID',
                    studentName: 'Vedant Dattatray Kulkarni',
                 
                  );
                  final res =await  managementCubit.createStudent(student: student);

                  Navigator.pop(context);
                },
                text: "Add",
              ),
            );
          },
        ),
      ),
    );
  }
}
