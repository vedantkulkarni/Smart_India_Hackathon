import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/models/ClassAttendance.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../models/ClassRoom.dart';
import '../../attendance.dart';

part 'class_details_state.dart';

class ClassDetailsCubit extends Cubit<ClassDetailsState> {
  String classRoomId;
  final AWSApiClient awsApiClient;
  late ClassRoom classRoom;
  var attendanceList;
  List<ClassAttendance>? classAttendanceListDate;
  ClassDetailsCubit({required this.classRoomId, required this.awsApiClient})
      : super(ClassDetailsInitial()) {
    getFullDetailsOfClassRoom(classRoomID: classRoomId);
  }

  Future<void> getFullDetailsOfClassRoom({required String classRoomID}) async {
    emit(LoadingClassDetails());

    classRoom = await awsApiClient.getClassRoom(classRoomID: classRoomID);
    // print(classRoo);
    emit(ClassRoomDetialsFetched());
  }


  Future<void> getAttendanceListDateWise({required String classRoomID}) async {
    emit(FectingAttendanceByDate());
    classAttendanceListDate =
        await awsApiClient.classAttendanceDateWiseList(classId: classRoomID);
    emit(AttendanceByDateFetched());
  }

  Future<void> getAttendanceListOfDate(
      {required String classRoomID, required String date}) async {
    emit(FetchingAttendanceList());

    List<SearchQuery> searchList = [];
    SearchQuery searchQueryClassID = SearchQuery(
        mode: AttendanceSearchMode.classID, searchText: classRoomID);
    SearchQuery searchQueryDateRange = SearchQuery(
        mode: AttendanceSearchMode.date,
        searchText: '${date}');
    searchList.add(searchQueryClassID);
    searchList.add(searchQueryDateRange);
    print(searchList);

    attendanceList =
        await awsApiClient.searchAttendance(searchQuery: searchList, limit: 40);

    emit(AttendanceListFetched());
  }
}
