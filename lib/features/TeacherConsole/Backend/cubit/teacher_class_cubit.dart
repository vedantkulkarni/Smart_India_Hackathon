import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../models/School.dart';
import '../../../AdminConsole/Backend/aws_api_client.dart';

part 'teacher_class_state.dart';

class TeacherClassCubit extends Cubit<TeacherClassState> {
  AWSApiClient awsApiClient;
  final School school;
  late ClassRoom classRoom;
  late List<CameraDescription> _cameras;
  TeacherClassCubit({required this.school, required this.awsApiClient})
      : super(TeacherClassInitial()) {
    fetchClassRoomDetailsForTeacher(
        classRoomID: '29d318a3-f09b-4675-bfb0-a73eb7c5dbbd');
  }

  Future<void> fetchClassRoomDetailsForTeacher(
      {required String classRoomID}) async {
    emit(TeacherClassInitial());
    classRoom = await awsApiClient.getClassRoom(classRoomID: classRoomID);
    print('here');
    print(classRoom.students);

    _cameras = await availableCameras();
    emit(ClassDetailsFetched());
  }

  //getter
  List<CameraDescription> get camerasList {
    return _cameras;
  }
}
