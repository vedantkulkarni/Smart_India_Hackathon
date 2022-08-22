import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../models/School.dart';
import '../../../../models/Student.dart';
import '../../../AdminConsole/Backend/aws_api_client.dart';

part 'teacher_class_state.dart';

class TeacherClassCubit extends Cubit<TeacherClassState> {
  AWSApiClient awsApiClient;
  final School school;
  late ClassRoom classRoom;
  late List<CameraDescription> _cameras;
  late List<Student> studentList;
  TeacherClassCubit(
      {required this.school,
      required this.awsApiClient,
      required String classRoomID})
      : super(TeacherClassInitial()) {
    fetchClassRoomDetailsForTeacher(classRoomID: classRoomID);
  }

  Future<void> fetchClassRoomDetailsForTeacher(
      {required String classRoomID}) async {
    emit(TeacherClassInitial());
    classRoom = await awsApiClient.getClassRoom(classRoomID: classRoomID);
    print('here');
    studentList = classRoom.students!;
    print(classRoom.students);

    _cameras = await availableCameras();
    emit(ClassDetailsFetched());
  }

  Future<Student> updateStudent({required Student student}) async {
    return await awsApiClient.updateStudent(updatedStudent: student);
  }

  //getter
  List<CameraDescription> get camerasList {
    return _cameras;
  }
}
