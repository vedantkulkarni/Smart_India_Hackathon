import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/role_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/admin_panel.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/Auth/Logic/auth_bloc/auth_cubit.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import '../../Auth/UI/pages/login_screen.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole({Key? key}) : super(key: key);

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return progressIndicator;
        }
        if (state is CredentialsNotCorrect) {
          print("Coming here");
          return Scaffold(
            body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Credentials not correct"),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 100,
                      child: CustomTextButton(
                        onPressed: () async {
                          await BlocProvider.of<AuthCubit>(context).signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        text: 'Try Again',
                      ),
                    ),
                  ],
                )),
          );
        }
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: ((context) => AdminCubit(
                  awsApiClient: getIt<AWSApiClient>(),
                  userID: BlocProvider.of<AuthCubit>(context).email,
                  roleChecker: getIt<RoleChecker>())))
        ], child: const AdminPanel());
      },
    );
  }
}
