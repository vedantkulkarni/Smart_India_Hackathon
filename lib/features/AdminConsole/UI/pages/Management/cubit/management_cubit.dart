import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/class_details_cubit.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../../../../models/Role.dart';
import '../../../../../../models/User.dart';

part 'management_state.dart';

class ManagementCubit extends Cubit<ManagementState> {
  AWSApiClient awsApiClient;
  ManagementMode managementMode;
  List<User> _userList = [];
  List<Student> _studentList = [];
  List<ClassRoom> _classroomList = [];

  ManagementCubit({required this.awsApiClient, required this.managementMode})
      : super(ManagementInitial()) {
    if (managementMode == ManagementMode.Students) {
      getAllStudents(limit: 10);
    } else if (managementMode == ManagementMode.User) {
      getAllUsers(role: Role.SuperAdmin);
    } else if (managementMode == ManagementMode.ClassRooms) {
      getAllClassRooms();
    }
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

  Future<User> getUser({required String userID}) async {
    return await awsApiClient.getAdminDetails();
  }

  Future<User> updateUser({required User updatedUser}) async {
    return await awsApiClient.updateUser(updatedUser: updatedUser);
  }

  Future<void> addNewUser({required User newUser}) async {
    emit(AddingUser());
    final createdUser = await awsApiClient.createUser(user: newUser);

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

  //Management mode = Students
  Future<void> getAllStudents({required int limit}) async {
    emit(FetchingStudents());
    _studentList = await awsApiClient.getListOfStudent(limit: 10);
    emit(StudentsFetched(studentsList: _studentList));
  }

  Future<Student> getStudent({required String studentID}) async {
    final student = await awsApiClient.getStudent(studentID: studentID);

    return student;
  }

  Future<void> createStudent({required Student student}) async {
    emit(CreatingStudent());
    final createdStudent = await awsApiClient.createStudent(student: student);
    emit(StudentCreated(student: createdStudent));
  }

  Future<void> deleteStudent({required String studentID}) async {
    emit(DeletingStudent());
    final deletedStudent = awsApiClient.deleteStudent(studentID: studentID);
    emit(StudentDeleted());
  }

  Future<void> updateStudent({required Student updatedStudent}) async {
    final result =
        await awsApiClient.updateStudent(updatedStudent: updatedStudent);
  }

  Future<void> bulkUpdateStudents(
      {required List<Student> bulkList, required String classRoomID}) async {
    for (var everyStudent in bulkList) {
      everyStudent = everyStudent.copyWith(classRoomStudentsId: classRoomID);
      await updateStudent(updatedStudent: everyStudent);
    }
    print('all students added');
  }

  void clearStudentList() {
    _studentList = [];
  }

  //ManagementMode = ClassRooms
  Future<void> getAllClassRooms() async {
    emit(FetchingClassRooms());
    _classroomList = await awsApiClient.getListOfClassrooms();
    emit(ClassRoomsFetched(classroomList: _classroomList));
  }

  Future<ClassRoom> getClassRoom({required String classRoomID}) async {
    emit(FetchingClassRooms());
    return await awsApiClient.getClassRoom(classRoomID: classRoomID);
  }

  Future<void> deleteClassRoom({required String classRoomID}) async {
    final deletedClassRoom =
        await awsApiClient.deleteClassRoom(classRoomID: classRoomID);
  }

  Future<ClassRoom> updateClassRoom(
      {required ClassRoom updatedClassRoom}) async {
    return await awsApiClient.updateClassRoom(classRoom: updatedClassRoom);
  }

  //getter
  List<Student> get studentsList {
    return _studentList;
  }
}
