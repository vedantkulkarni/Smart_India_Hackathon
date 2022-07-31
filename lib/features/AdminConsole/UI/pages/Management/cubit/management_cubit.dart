import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

import '../../../../../../models/Role.dart';
import '../../../../../../models/User.dart';

part 'management_state.dart';

class ManagementCubit extends Cubit<ManagementState> {
  AWSApiClient awsApiClient;
  ManagementMode managementMode;
  List<User> _userList = [];

  ManagementCubit({required this.awsApiClient, required this.managementMode})
      : super(ManagementInitial()) {
    if (managementMode == ManagementMode.Teachers) {
      fetchAllTeachers();
    } else if (managementMode == ManagementMode.User) {
      getAllUsers();
    }
  }

  //Management mode = teachers
  Future<void> fetchAllTeachers() async {
    emit(FetchingTeachers());
    _userList = await awsApiClient.getListOfUsers(role: Role.Teacher);
    emit(TeachersFetched(teacherList: usersList));
  }

  Future<void> addNewTeacher({required User newTeacher}) async {
    emit(AddingTeacher());
    final createdUser = await awsApiClient.createUser(user: newTeacher);

    // await fetchAllTeachers();
    emit(TeacherAdded());
  }

  Future<void> deleteTeacher({required String email}) async {
    emit(DeletingTeacher());
    final deletedTeacher = await awsApiClient.deleteUser(email: email);

    emit(TeacherDeleted());
  }

  //ManageMode = users
  Future<void> getAllUsers() async {
    emit(FetchingUsers());
    final superAdminList =
        await awsApiClient.getListOfUsers(role: Role.SuperAdmin);
    final adminList = await awsApiClient.getListOfUsers(role: Role.Admin);
    _userList = superAdminList + adminList;
    print(_userList);
    emit(UsersFetched(userList: _userList));
  }

  //getter
  List<User> get usersList {
    return _userList;
  }
}
