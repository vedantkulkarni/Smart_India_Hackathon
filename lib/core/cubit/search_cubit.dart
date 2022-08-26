import 'dart:core';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

import '../../../../../../models/Student.dart';
import '../../features/AdminConsole/UI/pages/attendance.dart';
import '../../models/Attendance.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchMode searchMode;
  AWSApiClient apiClient;
  List<Student> studentList = [];
  List<Attendance> attendanceList = [];
  SearchCubit({required this.searchMode, required this.apiClient})
      : super(SearchInitial());

  void emitSearch() {
    emit(SearchResults());
  }

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
      {required List<SearchQuery> searchQuery}) async {
    emit(Searching());
    attendanceList =
        await apiClient.searchAttendance(searchQuery: searchQuery, limit: 30);
    if (attendanceList.isEmpty) {
      emit(NoResultFound());
      return;
    }
    emit(SearchResults());
  }
}
