// import 'dar:ffi';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:team_dart_knights_sih/core/location_service.dart';
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
  Map<String, AttendanceStatus> attendanceMap = {};
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
    print(mode);
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
    attendanceMap[id] = attendanceMap[id] == AttendanceStatus.Absent
        ? AttendanceStatus.Present
        : AttendanceStatus.Absent;

    emit(AttendanceToggled(attendance: attendanceMap));
  }

  Future<void> initAttendance(List<Student> studentList) async {
    for (var everyStudent in studentList) {
      attendanceMap.putIfAbsent(
          everyStudent.studentID, () => AttendanceStatus.Present);
    }
  }

  Future<void> uploadManualAttendance({required ClassRoom classRoom}) async {
    emit(UploadingAttendance());
    final position = await determinePosition();
    final double latitude = position.latitude;
    final double longitude = position.longitude;
    print(latitude);
    print(longitude);

    for (var studentID in attendanceMap.entries) {
      var sutdentName = studList!
          .firstWhere((element) => element.studentID == studentID.key)
          .studentName;
      
      var status = attendanceMap[studentID.value] == AttendanceStatus.Present
          ? AttendanceStatus.Present
          : AttendanceStatus.Absent;
      final attendance = getAttendanceObj(
          studentName: sutdentName,
          className: classRoom.classRoomName,
          mode: mode,
          attendanceStatus: status,
          latitude: latitude,
          longitude: longitude,
          classID: classRoom.id,
          studentID: studentID.key);
      final uploadedAttendance =
          await apiClient.createAttendance(attendance: attendance);
      // print(attendance);
    }
    final percent = (presentStudents / attendanceMap.length) * 100;
    final classAttendance = ClassAttendance(
        classID: classRoom.id,
        date: TemporalDate(DateTime.now()),
        presentPercent: presentStudents.toDouble(),
        teacherEmail: teacher.email);
    final uploadedClassAttendance =
        await apiClient.createClassAttendance(classAttendance: classAttendance);
    // print(classAttendance);
    final updatedClassRoom =
        classRoom.copyWith(currentAttendanceDate: TemporalDate(DateTime.now()));
    final res = await apiClient.updateClassRoom(classRoom: updatedClassRoom);
    emit(AttendanceUploaded());
  }

  Attendance getAttendanceObj(
      {required VerificationStatus mode,
      required AttendanceStatus attendanceStatus,
      required double latitude,
      required double longitude,
      required String classID,
      required String className,
      required String studentName,
      required String studentID}) {
    final Attendance attendance = Attendance(
      geoLatitude: latitude,
      geoLongitude: longitude,
      studentName: studentName,
      className: className,
      classID: classID,
      date: TemporalDate(DateTime.now()),
      status: attendanceStatus,
      studentID: studentID,
      teacherID: teacher.email,
      teacherName: teacher.name,
      time: TemporalTime(DateTime.now()),
      verification: mode,
    );
    return attendance;
  }

  int get presentStudents {
    var count = 0;
    var present = attendanceMap.entries.forEach((element) {
      if (element.value == AttendanceStatus.Present) {
        count++;
      }
    });
    return count;
  }
}
