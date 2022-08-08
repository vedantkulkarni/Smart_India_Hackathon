import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

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
    // signInTeacher(userName, password);
    getTeacherDetails(userID: userID);
  }
  bool isSignedIn = false;
  Future<void> signInTeacher(String username, String password) async {}

  Future<void> getTeacherDetails({required String userID}) async {
     final teacher = await awsApiClient.getAdminDetails(userID: userID);
    // final teacher = User(
    //   email: 'vednt@gmail.com ',
    //   name: 'Vedant Kulkanir',
    //   phoneNumber: '+91 9623026654',
    //   schoolID: 'some id',
    //   role: Role.Admin,
    // );
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
    // school = School(
    //   schoolID: 'some id',
    //   schoolName: 'School Name',
    //   superAdmin: 'vedantk60@gmail.com',
    // );
    print(school);
    emit(SchoolFetched());
  }
}
