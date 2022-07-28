import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/create_school.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';

class SchoolNotFoundPage extends StatelessWidget {
  const SchoolNotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminCubit = BlocProvider.of<AdminCubit>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            adminCubit.checkUserRole(UserRole.CanCreateSchool)
                ? CustomTextButton(
                    onPressed: () {
                      print('wtf');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (((_) => BlocProvider.value(
                                value: BlocProvider.of<AdminCubit>(context),
                                child: CreateSchoolPage(),
                              )))));
                    },
                    text: 'Create School')
                : Container(),
          ],
        ),
      ),
    );
  }
}
