import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/core/errors/exceptions.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/role_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../models/School.dart';
import '../../../../models/User.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AWSApiClient awsApiClient;
  RoleChecker roleChecker;
  String userID;
  late School school;
  late User adminUser;
  AdminCubit(
      {required this.awsApiClient,
      required this.userID,
      required this.roleChecker})
      : super(AdminInitial()) {
    getAdminDetails(userID: userID);
  }

  Future<void> getAdminDetails({required String userID}) async {
    adminUser = await awsApiClient.getAdminDetails();
    roleChecker.setUser(adminUser);
    print("User fetched : $adminUser");
    if (adminUser.schoolID == null) {
      emit(SchoolNotFound());
      return;
    }
    try {
      await getSchoolDetails(schoolID: adminUser.schoolID!);
      emit(SchoolDetailsFetched());
    } on SchoolNotFoundException {
      emit(SchoolNotFound());
      return;
    }
    emit(AdminDetailsFetched());
  }

  Future<void> updateAdminDetails({required User user}) async {
    adminUser = await awsApiClient.updateUser(updatedUser: user);
    emit(AdminDetailsUpdated());
    emit(AdminDetailsFetched());
  }

  Future<void> getSchoolDetails({required String schoolID}) async {
    if (schoolID == null) {
      emit(NoSchoolSet());
    }
    school = await awsApiClient.getSchoolDetails(schoolID: schoolID);
    emit(SchoolDetailsFetched());
  }

  //School
  Future<void> createSchool({required School school}) async {
    emit(CreatingSchool());
    final createdSchool = await awsApiClient.createSchool(school: school);
    school = createdSchool;
    print("School Created : $school");
    await updateAdminDetails(
        user: adminUser.copyWith(schoolID: school.schoolID));
    print("admin details updated");
    emit(SchoolCreated());
    emit(SchoolDetailsFetched());
  }


  //ClassRoom
  Future<void> createClassRoom({required ClassRoom classRoom})async
  {
    
  }
       
  //Role Check
  bool checkUserRole(UserRole checkRole) {
    if (checkRole == UserRole.CanCreateSchool) {
      return roleChecker.canCreateSchool;
    } else {
      return false;
    }
  }

  //getters
  String get adminID {
    return adminUser.email;
  }

  User get admin {
    return adminUser;
  }
}
