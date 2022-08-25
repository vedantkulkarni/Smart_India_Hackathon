import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/core/errors/exceptions.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/role_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../models/Group.dart';
import '../../../../models/School.dart';
import '../../../../models/User.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  bool isAnalyticsFetched = false;
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
    adminUser = await awsApiClient.getAdminDetails(userID: userID);
    roleChecker.setUser(adminUser);
    print("User fetched : $adminUser");
    if (adminUser.schoolID == null) {
      emit(SchoolNotFound());
      print("school id is null");
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

  // Future<void> getSchoolName({required String userId})async{
  //    adminUser = await awsApiClient.getAdminDetails(userID: userID);
  //   roleChecker.setUser(adminUser);
  //   String schoolID=adminUser.schoolID;
  //   getSchoolDetails(schoolID)
  // }

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
    print(school);
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

  //Groups
  Future<void> createGroup({required Group group}) async {}

  //ClassRoom
  Future<void> createClassRoom({required ClassRoom classRoom}) async {
    emit(CreatingClassRoom());
    final createdClassRoom =
        await awsApiClient.createClassRoom(classRoom: classRoom);
    emit(ClassRoomCreated());
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
