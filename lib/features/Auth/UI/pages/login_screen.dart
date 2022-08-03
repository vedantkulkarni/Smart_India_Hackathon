import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/core/platform_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/admin_console.dart';
import 'package:team_dart_knights_sih/features/Auth/Logic/auth_bloc/auth_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/UI/teacher_console.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/screens/homeScreen.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    return null;
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Smart Attendance App',
      // logo: const AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      theme: LoginTheme(
        titleStyle: const TextStyle(
          color: primaryColor,
          fontFamily: 'Quicksand',
          letterSpacing: 2,
          fontSize: 24,
        ),
        primaryColor: whiteColor,
        buttonTheme: LoginButtonTheme(
            splashColor: secondaryColor,
            backgroundColor: primaryColor,
            highlightColor: primaryColor,
            elevation: 9.0,
            highlightElevation: 6.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: primaryColor.withOpacity(0.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: const TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
          labelStyle: const TextStyle(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.normal),
        ),
      ),

      onSubmitAnimationCompleted: () {
        if (getIt<PlatformChecker>().isDesktop) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              // builder: (context) => DashboardScreen(),
              builder: ((ctx) => BlocProvider(
                    create: (context) =>
                        AuthCubit(awsApiClient: getIt<AWSApiClient>()),
                    child: const AdminConsole(),
                  ))));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              // builder: (context) => DashboardScreen(),
              builder: ((context) => HomeScreen())));
        }
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
