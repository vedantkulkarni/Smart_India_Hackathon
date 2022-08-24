part of 'student_details_cubit_cubit.dart';

abstract class StudentDetailsCubitState extends Equatable {
  const StudentDetailsCubitState();

  @override
  List<Object> get props => [];
}

class StudentDetailsCubitInitial extends StudentDetailsCubitState {}
class StudentDetailsInitial extends StudentDetailsCubitState {}

class FetchingStudentDetails extends StudentDetailsCubitState {}

class StudentDetailsFetched extends StudentDetailsCubitState {}