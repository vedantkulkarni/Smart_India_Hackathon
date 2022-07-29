part of 'management_cubit.dart';


abstract class ManagementState {}

class ManagementInitial extends ManagementState {}

class AddingTeacher extends ManagementState {}
class TeacherAdded extends ManagementState {}
class FetchingTeachers extends ManagementState {}
class DeletingTeacher extends ManagementState {}
class TeacherDeleted extends ManagementState {}

class TeachersFetched extends ManagementState {
  final List<User> teacherList;
  TeachersFetched({required this.teacherList});
}
