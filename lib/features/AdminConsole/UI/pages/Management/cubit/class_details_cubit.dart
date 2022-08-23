import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/models/ClassAttendance.dart';

import '../../../../../../models/ClassRoom.dart';

part 'class_details_state.dart';

class ClassDetailsCubit extends Cubit<ClassDetailsState> {
  String classRoomId;
  final AWSApiClient awsApiClient;
  late ClassRoom classRoom;
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

}
