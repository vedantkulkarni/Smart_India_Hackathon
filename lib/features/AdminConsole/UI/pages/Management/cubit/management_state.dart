part of 'management_cubit.dart';

abstract class ManagementState extends Equatable {}

class ManagementInitial extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddingStudent extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StudentAdded extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchingStudents extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DeletingStudent extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StudentDeleted extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}



class StudentsFetched extends ManagementState {
  final List<User> studentsList;
  StudentsFetched({required this.studentsList});

  @override
  // TODO: implement props
  List<Object?> get props => [studentsList];
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
