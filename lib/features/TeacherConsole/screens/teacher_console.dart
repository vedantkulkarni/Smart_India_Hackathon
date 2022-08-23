import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/screens/homeScreen.dart';


import '../../../amplifyconfiguration.dart';
import '../../../injection_container.dart';
import '../../../models/ModelProvider.dart';
import '../../AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import '../../AdminConsole/Backend/admin_bloc/role_checker.dart';
import '../../AdminConsole/Backend/aws_api_client.dart';
import '../../Auth/Logic/auth_bloc/auth_cubit.dart';



class TeacherConsole extends StatefulWidget {
  String userName;
  String password;
  TeacherConsole({Key? key, required this.userName, required this.password})
      : super(key: key);

  @override
  State<TeacherConsole> createState() => _TeacherConsoleState();
}

class _TeacherConsoleState extends State<TeacherConsole> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<TeacherCubit>(context),
      child: HomeScreen(),
    );
  }
}

