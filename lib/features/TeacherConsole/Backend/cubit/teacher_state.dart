part of 'teacher_cubit.dart';

abstract class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object> get props => [];
}

class TeacherInitial extends TeacherState {}
class CredentialsNotCorrect extends TeacherState {}
class FetchingTeacher extends TeacherState {}
class TeacherDetailsFetched extends TeacherState {}
class SchoolNotFound extends TeacherState {}
class SchoolFetched extends TeacherState {}
class SchoolNotSet extends TeacherState {}
