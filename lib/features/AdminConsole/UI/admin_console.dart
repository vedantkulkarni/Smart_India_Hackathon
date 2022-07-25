import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/admin_panel.dart';
import 'package:team_dart_knights_sih/features/Auth/Logic/auth_bloc/auth_cubit.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

class AdminConsole extends StatefulWidget {
  AdminConsole({Key? key}) : super(key: key);

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: ((context) => AuthCubit(awsApiClient: getIt<AWSApiClient>()))),
      BlocProvider(create: ((context) => AdminCubit(awsApiClient: getIt<AWSApiClient>())))
    ], child: AdminPanel());

  }
}
