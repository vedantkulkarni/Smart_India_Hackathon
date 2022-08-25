import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../models/Student.dart';
import '../../../../Backend/aws_api_client.dart';

part 'student_details_cubit_state.dart';

class StudentDetailsCubitCubit extends Cubit<StudentDetailsCubitState> {
  Student student;
  AWSApiClient apiClient;
  Student? studentDeatail;
  StudentDetailsCubitCubit({required this.student, required this.apiClient})
      : super(StudentDetailsCubitInitial()) {
    getStudentDetails(student: student);
  }

  Future<void> getStudentDetails({required Student student}) async {
    emit(FetchingStudentDetails());
    //code
    studentDeatail = await apiClient.getStudent(studentID: student.studentID);
    print(studentDeatail);
    emit(StudentDetailsFetched());
  }
}
