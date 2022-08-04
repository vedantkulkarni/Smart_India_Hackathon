import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    signInTeacher(userName, password);
  }

  bool isSignedIn = false;

  Future<void> signInTeacher(String username, String password) async {
    try {
      await Amplify.Auth.signOut();
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );

      isSignedIn = result.isSignedIn;
      if (isSignedIn) {
        await getTeacherDetails(userID: userID);
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> getTeacherDetails({required String userID}) async {
    final teacher = await awsApiClient.getAdminDetails(userID: userID);
    print(teacher);

    // try {
    //   await getSchoolDetails(schoolID: teacher.schoolID!);
    //   emit(SchoolDetailsFetched());
    // } on SchoolNotFoundException {
    //   emit(SchoolNotFound());
    //   return;
    // }
    emit(TeacherDetailsFetched());
  }
}
