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

class FetchingStudentDetails extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreatingStudent extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StudentCreated extends ManagementState {
  final Student student;
  StudentCreated({required this.student});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StudentDetailsFetched extends ManagementState {
  Student student;
  StudentDetailsFetched({required this.student});

  @override
  // TODO: implement props
  List<Object?> get props => [student];
}

class StudentsFetched extends ManagementState {
  final List<Student> studentsList;
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

class UpdatingUser extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserUpdated extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}



//ClassRooms
class FetchingClassRooms extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ClassRoomsFetched extends ManagementState {
  final List<ClassRoom> classroomList;
  ClassRoomsFetched({required this.classroomList});
  @override
  // TODO: implement props
  List<Object?> get props => [classroomList];
}

//Leaves
class FetchingLeaves extends ManagementState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LeavesFetched extends ManagementState {
  final List<Leave> leaves;
  LeavesFetched({required this.leaves});
  @override
  // TODO: implement props
  List<Object?> get props => [leaves];
}

