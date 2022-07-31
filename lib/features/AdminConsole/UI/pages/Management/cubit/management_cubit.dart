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
      getAllUsers(role: Role.SuperAdmin);
    }
  }

  //Management mode = teachers
  Future<void> fetchAllTeachers() async {
    emit(FetchingTeachers());
    _userList = await awsApiClient.getListOfUsers(role: Role.Teacher);
    emit(TeachersFetched(teacherList: usersList));
  }

  //ManagementMode = users
  Future<void> getAllUsers({required Role role}) async {
    emit(FetchingUsers());
    final _userList = await awsApiClient.getListOfUsers(role: role);
    // final adminList = await awsApiClient.getListOfUsers(role: Role.Admin);
    // _userList = superAdminList + adminList;
    print(_userList);
    emit(UsersFetched(userList: _userList));
  }

  Future<void> addNewUser({required User newUser}) async {
    emit(AddingUser());
    final createdUser = await awsApiClient.createUser(user: newUser);

    // await fetchAllTeachers();
    emit(UserAdded());
  }

  Future<void> deleteUser({required String email}) async {
    emit(DeletingUser());
    final deletedTeacher = await awsApiClient.deleteUser(email: email);

    emit(UserDeleted());
  }

  void clearUserList() {
    _userList = [];
  }

  //getter
  List<User> get usersList {
    return _userList;
  }
}
