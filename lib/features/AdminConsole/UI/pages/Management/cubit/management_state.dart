part of 'management_cubit.dart';

abstract class ManagementState extends Equatable {}

class ManagementInitial extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddingTeacher extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TeacherAdded extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchingTeachers extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}



class TeachersFetched extends ManagementState {
  final List<User> teacherList;
  TeachersFetched({required this.teacherList});

  @override
  // TODO: implement props
  List<Object?> get props => [teacherList];
}

class FetchingUsers extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AddingUser extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UserAdded extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class DeletingUser extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UserDeleted extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UsersFetched extends ManagementState {
  final List<User> userList;
  UsersFetched({required this.userList});
  @override
  // TODO: implement props
  List<Object?> get props => [userList];
}
