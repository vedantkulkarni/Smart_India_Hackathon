import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/attendance.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../core/constants.dart';
import '../../../../models/Attendance.dart';
import '../../../../models/School.dart';
import '../../../../models/Student.dart';
import '../../../AdminConsole/Backend/aws_api_client.dart';

part 'teacher_class_state.dart';

class TeacherClassCubit extends Cubit<TeacherClassState> {
  AWSApiClient awsApiClient;
  List<Attendance>? attendanceList;
  final School school;
  late ClassRoom classRoom;
  late List<CameraDescription> _cameras;
  late List<Student> studentList;
  TeacherClassCubit(
      {required this.school,
      required this.awsApiClient,
      required String classRoomID})
      : super(TeacherClassInitial()) {
    getCameras();
    fetchClassRoomDetailsForTeacher(classRoomID: classRoomID);
  }

  Future<void> getCameras() async {
    _cameras = await availableCameras();
    // emit(CamerasFetched());
  }

  Future<void> fetchClassRoomDetailsForTeacher(
      {required String classRoomID}) async {
    emit(TeacherClassInitial());
    classRoom = await awsApiClient.getClassRoom(classRoomID: classRoomID);

    print('here');
    studentList = [...classRoom.students!];
    
    print("classRoom students length is : ${classRoom.students!.length}");
    if (classRoom.currentAttendanceDate != null) {}

    emit(ClassDetailsFetched());
  }

  Future<Student> updateStudent({required Student student}) async {
    return await awsApiClient.updateStudent(updatedStudent: student);
  }

  Future<void> analytics({required String classRoomID}) async {
    if (classRoom.currentAttendanceDate != null) {
      List<SearchQuery> searchList = [];
      SearchQuery searchQueryClassID = SearchQuery(
          mode: AttendanceSearchMode.classID, searchText: classRoomID);
      SearchQuery searchQueryDateRange = SearchQuery(
          mode: AttendanceSearchMode.date,
          searchText: '${classRoom.currentAttendanceDate}');
      searchList.add(searchQueryClassID);
      searchList.add(searchQueryDateRange);

      attendanceList = await awsApiClient.searchAttendance(
          searchQuery: searchList, limit: 40);
    }
  }

  //helper
  // int calcAverage(){
  //   double sum = 0;
  //   for(var i in attendanceList)
  //   {
  //     sum+=i.;
  //   }
  // }

  //getter
  List<CameraDescription> get camerasList {
    return _cameras;
  }
}
