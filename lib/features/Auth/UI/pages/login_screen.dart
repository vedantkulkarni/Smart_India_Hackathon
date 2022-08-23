import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/core/platform_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/admin_console.dart';
import 'package:team_dart_knights_sih/features/Auth/Logic/auth_bloc/auth_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/screens/homeScreen.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import '../../../TeacherConsole/Backend/cubit/teacher_cubit.dart';
import '../../../TeacherConsole/screens/teacher_console.dart';

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
  String userName = '';
  String password = '';
  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    userName = data.name;
    password = data.password;
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
        double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context, designSize: Size(width, height));
    return FlutterLogin(
      title: 'Smart Attendance App',
      // logo: const AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      theme: LoginTheme(
        titleStyle: TextStyle(
          color: primaryColor,
          fontFamily: 'Quicksand',
          letterSpacing: 2,
          fontSize: 24.sp,
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
          labelStyle: TextStyle(
              fontSize: 16.sp, color: primaryColor, fontWeight: FontWeight.normal),
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
              builder: ((ctx) => MultiBlocProvider(providers: [
                    // BlocProvider.value(value: BlocProvider.of<AuthCubit>(context)),
                    BlocProvider(
                      create: ((_) => TeacherCubit(
                            awsApiClient: getIt<AWSApiClient>(),
                            userName: userName,
                            password: password,
                            userID: 'vedantk60@gmail.com',
                          )),
                    ),
                  ], child: TeacherConsole(password: password,userName: userName,)))));
        }
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
