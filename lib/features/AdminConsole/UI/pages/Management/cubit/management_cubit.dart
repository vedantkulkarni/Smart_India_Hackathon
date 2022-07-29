import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    }
  }

  Future<void> fetchAllTeachers() async {
    emit(FetchingTeachers());
    _userList = await awsApiClient.getListOfUsers(role: Role.SuperAdmin);
    emit(TeachersFetched(teacherList: usersList));
  }

  Future<void> addNewTeacher({required User newTeacher}) async {
    emit(AddingTeacher());
    final createdUser = await awsApiClient.createUser(user: newTeacher);
    print(createdUser);
    await fetchAllTeachers();
    emit(TeacherAdded());
  }

  Future<void> deleteTeacher({required String email}) async {
    emit(DeletingTeacher());
    final deletedTeacher = await awsApiClient.deleteUser(email: email);
    emit(TeacherDeleted());
  }

  //getter
  List<User> get usersList {
    return _userList;
  }
}
