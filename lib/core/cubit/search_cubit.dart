import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

import '../../../../../../models/Student.dart';
import '../../models/Attendance.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchMode searchMode;
  AWSApiClient apiClient;
  List<Student> studentList = [];
  List<Attendance> attendanceList = [];
  SearchCubit({required this.searchMode, required this.apiClient})
      : super(SearchInitial());

  Future<void> searchStudent(
      {required String searchQuery, required StudentSearchMode mode}) async {
    emit(Searching());
    studentList =
        await apiClient.searchStudent(searchQuery: searchQuery, mode: mode);
    if (studentList.isEmpty) {
      emit(NoResultFound());
      return;
    }
    emit(SearchResults());
  }

  Future<void> searchAttendance(
      {required String searchQuery, required AttendanceSearchMode mode}) async {
         emit(Searching());
    attendanceList =
        await apiClient.searchAttendance(searchQuery: searchQuery, mode: mode,limit: 25);
    if (attendanceList.isEmpty) {
      emit(NoResultFound());
      return;
    }
    emit(SearchResults());
      }
}
