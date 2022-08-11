// import 'dar:ffi';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/camera_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_detector.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/ml_service.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../../models/Student.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AWSApiClient apiClient;
  final VerificationStatus mode;
  final User teacher;
  final FaceDetectorService faceDetectorService;
  final MLService mlService;
  final CameraService cameraService;
  List<Student>? studList;
  Map<String, bool> attendanceMap = {};
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  bool _detectingFaces = false;
  bool pictureTaken = false;

  final bool _initializing = false;

  final bool _saving = true;
  final bool _bottomSheetVisible = false;

  // final ClassRoom classRoom;
  AttendanceCubit(
      {required this.apiClient,
      required this.faceDetectorService,
      required this.mlService,
      required this.cameraService,
      required this.mode,
      required this.teacher,
      this.studList})
      : super(AttendanceInitial()) {
    if (mode == VerificationStatus.ManualAttendance) {
      initAttendance(studList!);
    } else {
      faceDetectorService.initialize();
      initializeInterPreter();
    }
  }

  Future<void> initializeInterPreter() async {
    emit(InitializingMLModel());
    faceDetectorService.initialize();
    await cameraService.initialize();
    await mlService.initialize();
    print("model initializedb");
    emit(MLModelInitialized());
  }

  void startPredicting() {
    imageSize = cameraService.getImageSize();
    print(imageSize);
    emit(ScanningAttendance());
    cameraService.cameraController?.startImageStream((image) async {
      if (cameraService.cameraController != null) {
        if (_detectingFaces) return;

        _detectingFaces = true;

        try {
          await faceDetectorService.detectFacesFromImage(image);
          if (faceDetectorService.faces.isNotEmpty) {
            faceDetected = faceDetectorService.faces[0];
            emit(FacesDetected());

            mlService.setCurrentPrediction(image, faceDetected);

            emit(CurrentPredictionSet());
          } else {
            emit(NoFacesDetected());
          }

          _detectingFaces = false;
        } catch (e) {
          print(e);
          _detectingFaces = false;
        }
      }
    });
  }

  Future<void> compareDetectedResults() async {
    emit(ComparingResults());
    final result = await mlService.predict();
    if (result == null) {
      print('student not recognized');
      emit(StudentNotRecognized());
    } else {
      print('attendance marked for student : $result');
      emit(AttendanceMarked(student: result));
    }
  }

  Future<void> addStudentFacialDataToDatabase(
      {required Student student}) async {
    List<dynamic> modelData = mlService.predictedData;
    print(modelData[0].runtimeType);
    final updatedStudent =
        student.copyWith(modelData: modelData as List<double>);
    final result =
        await apiClient.updateStudent(updatedStudent: updatedStudent);
    print(result);
  }

  void toggleAttendance(String id) {
    attendanceMap[id] = !attendanceMap[id]!;
    emit(AttendanceToggled(attendance: attendanceMap));
  }

  Future<void> initAttendance(List<Student> studentList) async {
    for (var everyStudent in studentList) {
      attendanceMap.putIfAbsent(everyStudent.studentID, () => true);
    }
  }

  Future<void> uploadManualAttendance() async {
    emit(UploadingAttendance());
    for (var everyStudent in attendanceMap.entries) {
      var status = attendanceMap[everyStudent] == true
          ? AttendanceStatus.Present
          : AttendanceStatus.Absent;
      var verificationStatus = mode;
      // final attendance = _createAttendanceObj(
      //     studentID: everyStudent.key,
      //     status: status,
      // //     verificationStatus: verificationStatus);
      // final uploadedAttendance =
      //     await apiClient.createAttendance(attendance: attendance);
      // print(uploadedAttendance);
    }
    emit(AttendanceUploaded());
  }

//   Attendance _createAttendanceObj(
//       {required String studentID,
//       required AttendanceStatus status,
//       required VerificationStatus verificationStatus}) {
//     // final attendance = Attendance(
//     //   classID: ,
//     //     studentID: studentID,
//     //     date: TemporalDate(DateTime.now()),
//     //     status: status,
//     //     time: TemporalTime(DateTime.now()),
//     //     verification: verificationStatus,
//     //     geoLocation: 'https://goo.gl/maps/KDFc2gjvhfSxKPK47',
//     //     teacherID: teacher.email,
//     //     teacherName: teacher.name);

//     return attendance;
//   }
}
