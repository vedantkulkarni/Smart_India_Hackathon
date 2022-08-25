import 'dart:io';

import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../models/School.dart';
import '../../../../models/User.dart';
import '../../../AdminConsole/Backend/admin_bloc/role_checker.dart';
import '../../../AdminConsole/Backend/aws_api_client.dart';

part 'teacher_state.dart';

class TeacherCubit extends Cubit<TeacherState> {
  AWSApiClient awsApiClient;
  String userName;
  String password;
  String userID;
  late School school;
  late User teacher;

  TeacherCubit(
      {required this.awsApiClient,
      required this.userID,
      required this.userName,
      required this.password})
      : super(TeacherInitial()) {
    isUserSignedIn();
    signInTeacher(userName, password);
    getTeacherDetails(userID: userID);
  }
  bool isSignedIn = false;
  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<void> signInTeacher(String username, String password) async {
    await Amplify.Auth.signOut();
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      isSignedIn = result.isSignedIn;
      if (isSignedIn) {
        getTeacherDetails(userID: username);
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> getTeacherDetails({required String userID}) async {
    teacher = await awsApiClient.getAdminDetails(userID: userID);
    print(teacher);

    try {
      await getSchoolDetails(schoolID: teacher.schoolID!);
      emit(SchoolFetched());
    } on SchoolNotFoundException {
      emit(SchoolNotFound());
      return;
    }
    emit(TeacherDetailsFetched());
  }

  Future<void> getSchoolDetails({required String schoolID}) async {
    if (schoolID == null) {
      emit(SchoolNotSet());
    }
    school = await awsApiClient.getSchoolDetails(schoolID: schoolID);

    print(school);
    emit(SchoolFetched());
  }
}
