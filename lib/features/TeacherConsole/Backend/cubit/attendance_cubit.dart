// import 'dar:ffi';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:team_dart_knights_sih/core/attendance_upload_service.dart';
import 'package:team_dart_knights_sih/core/location_service.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/camera_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_detector.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mediapipe/anchors.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mediapipe/isolate_utils.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mediapipe/options_face.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/ml_service.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';
import 'package:image/image.dart' as imglib;

import '../../../../injection_container.dart';
import '../../Attendance/mediapipe/model_inference_service.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AWSApiClient apiClient;
  final IsolateUtils _isolateUtils = IsolateUtils();
  final VerificationStatus mode;
  final ModelInferenceService _modelInferenceService =
      getIt<ModelInferenceService>();
  final User teacher;
  final FaceDetectorService faceDetectorService;
  final MLService mlService;
  final CameraService cameraService;
  late final OptionsFace optionsFace;
  late final AnchorOption anchor;
  List<Student>? studList;
  Map<String, AttendanceStatus> attendanceMap = {};
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  bool _detectingFaces = false;
  bool pictureTaken = false;

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
      initAttendance(studList!, AttendanceStatus.Present);
    } else if (mode == VerificationStatus.FaceVerified) {
      initCamera();
    } else if (mode == VerificationStatus.FaceDetectedAndVerified) {
      print("coming here");
      initAttendance(studList!, AttendanceStatus.Absent);
      initServices(mode);
    } else if (mode == VerificationStatus.FaceVerifiedWithLiveness) {
      initAttendance(studList!, AttendanceStatus.Absent);
      initServices(mode);
    } else {
      faceDetectorService.initialize();
      initializeInterPreter();
      initializeMediapipe();
    }
  }

  Future<void> initServices(VerificationStatus mode) async {
    if (mode == VerificationStatus.FaceDetectedAndVerified ||
        mode == VerificationStatus.FaceVerifiedWithLiveness) {
      await initializeInterPreter();
      await initCamera();
      // await initializeMediapipe();
      faceDetectorService.initialize();
    }
  }

  Future<void> initCamera() async {
    emit(InitializingCamera());
    await cameraService.initialize();
    emit(CameraInitialized());
    // emit(StudentNotSelected());
  }

  Future<void> initializeInterPreter() async {
    emit(InitializingMLModel());

    await mlService.initialize();

    print("model initializedb");
    emit(MLModelInitialized());
  }

  // void startPredicting() {
  //   imageSize = cameraService.getImageSize();
  //   print(imageSize);
  //   emit(StartingImageStream());
  //   cameraService.cameraController?.startImageStream((image) async {
  //     if (cameraService.cameraController != null) {
  //       if (_detectingFaces) return;

  //       _detectingFaces = true;

  //       try {
  //         await faceDetectorService.detectFacesFromImage(image);
  //         if (faceDetectorService.faces.isNotEmpty) {
  //           faceDetected = faceDetectorService.faces[0];
  //           // emit(FacesDetected());

  //           // mlService.setCurrentPrediction(image, faceDetected);

  //           emit(CurrentPredictionSet());
  //         } else {
  //           emit(NoFacesDetected());
  //         }

  //         _detectingFaces = false;
  //       } catch (e) {
  //         print(e);
  //         _detectingFaces = false;
  //       }
  //     }
  //   });
  // }

  Future<void> uploadLeave({required Leave leave}) async {
    emit(UploadingLeave());
    await apiClient.createLeave(leave: leave);
    emit(LeaveUploaded());
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

  Future<void> initAttendance(
      List<Student> studentList, AttendanceStatus status) async {
    for (var everyStudent in studentList) {
      attendanceMap.putIfAbsent(everyStudent.studentID, () => status);
    }
  }

  Future<void> studentGotSelected({required Student student}) async {
    emit(StudentSelected(student: student));
  }

  Future<void> uploadAttendance({required ClassRoom classRoom}) async {
    emit(UploadingAttendance());
    print("coming here");
    final position = await determinePosition();
    final double latitude = position.latitude;
    final double longitude = position.longitude;
    print(latitude);
    print(longitude);
    print(attendanceMap);
    // return;

    List<Attendance> attendanceList = [];
    for (var studentID in attendanceMap.entries) {
      var sutdentName = studList!
          .firstWhere((element) => element.studentID == studentID.key)
          .studentName;
      print(attendanceMap);

      var status = attendanceMap[studentID.key];
      final attendance = getAttendanceObj(
          studentName: sutdentName,
          className: classRoom.classRoomName,
          mode: mode,
          attendanceStatus: status!,
          latitude: latitude,
          longitude: longitude,
          classID: classRoom.id,
          studentID: studentID.key);
      attendanceList.add(attendance);
      // final uploadedAttendance =
      //     await apiClient.createAttendance(attendance: attendance);
      // print(attendance);
    }
    final percent = (presentStudents / attendanceMap.length) * 100;
    // final String classAttendanceID = "${classRoom.id}#${TemporalDate(DateTime.now())}";
    final classAttendance = ClassAttendance(
        classID: classRoom.id,
        date: TemporalDate(DateTime.now()),
        time: TemporalTime(DateTime.now()),
        presentPercent: presentStudents.toDouble(),
        teacherEmail: teacher.email);
    // final uploadedClassAttendance =
    //     await apiClient.createClassAttendance(classAttendance: classAttendance);
    // print(classAttendance);
    final updatedClassRoom =
        classRoom.copyWith(currentAttendanceDate: TemporalDate(DateTime.now()));
    AttendanceUploadModel attendanceUploadModel = AttendanceUploadModel(
        updatedClassRoom: updatedClassRoom,
        date: TemporalDate(DateTime.now()),
        time: TemporalTime(DateTime.now()),
        attendanceList: attendanceList,
        classAttendance: classAttendance);
    final uploadAttendanceRes = await getIt<AttendanceUploadService>()
        .uploadAttendance(attendanceUploadModel: attendanceUploadModel);
    if (uploadAttendanceRes) {
      emit(AttendanceUploaded());
    } else {
      emit(AttendanceStoredToLocalStore());
    }
    // final res = await apiClient.updateClassRoom(classRoom: updatedClassRoom);
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

  //Face Verification

  Future<void> initializeMediapipe() async {
    await _isolateUtils.initIsolate();
    _modelInferenceService.setModelConfig(0);
    // await cameraService.cameraController!.buildPreview();
    emit(InitializedAllServices());
  }

  void markPresent({required Student student}) {
    attendanceMap[student.studentID] = AttendanceStatus.Present;
    emit(StudentSelected(student: student));
  }

  var isPredicting = false;
  CameraImage? _cameraImage;
  Rect? face;
  void startPredictingMediaPipe(BuildContext context) {
    isPredicting = true;
    imageSize = cameraService.getImageSize();
    emit(StartingImageStream());
    cameraService.cameraController?.startImageStream((cameraImage) async {
      _cameraImage = cameraImage;

      if (cameraService.cameraController != null) {
        if (_detectingFaces) return;

        _detectingFaces = true;
        await _inference(cameraImage: cameraImage);
      }
    });
  }

  Future<List<Face>> detectFacesFromImage(InputImage image) async {
    List<Face> faces =
        await faceDetectorService.faceDetector.processImage(image);
    // print(faces[0].boundingBox);

    return faces;
  }

  Future<void> _inference({required CameraImage cameraImage}) async {
    //discarder
    // if (!mounted) return;

    if (_modelInferenceService.model.interpreter != null) {
      // if (_detectingFaces) {
      //   return;
      // }

      _detectingFaces = true;

      await _modelInferenceService.inference(
        isolateUtils: _isolateUtils,
        cameraImage: cameraImage,
      );

      print(_modelInferenceService.inferenceResults);
      if (_modelInferenceService.inferenceResults != null) {
        face = _modelInferenceService.inferenceResults?['bbox'];
        emit(FacesDetected(
            cameraImage, _modelInferenceService.inferenceResults?['bbox']));
      }

      _detectingFaces = false;
    } else {
      print("interpreter is null");
    }
  }

  List<Student> predictedStudents = [];
  Future<void> predictAttendanceForGivenList(
      {required List<Face> studentFaces, required imglib.Image? image}) async {
    print("detected faces are ${studentFaces.length}");
    emit(ComparingResults());
    for (var face in studentFaces) {
      print(face.boundingBox);

      setCurrentPrediction(detectedFace: face, image: image);

      compareDetectedResults();
    }

    emit(AttendanceMarked(studentList: predictedStudents));
    predictedStudents.clear();
  }

  Future<void> setCurrentPrediction(
      {Face? detectedFace, imglib.Image? image}) async {
    print('Setting current prediction');
    face = detectedFace!.boundingBox;
    mlService.setCurrentPrediction(image!, face);
    emit(CurrentPredictionSet());
  }

  Future<void> compareDetectedResults() async {
    final result = await mlService.predict();
    if (result == null) {
      print('student not recognized');
      // emit(StudentNotRecognized());
    } else {
      print('attendance marked for student : $result');
      predictedStudents.add(result);
      // emit(AttendanceMarked(student: result));
    }
  }

  Future<void> compareDetectedResultsWithStudent(Student student) async {
    emit(ComparingResults());
    final result = mlService.compareFaces(student.modelData!);
    if (result == false) {
      print('student not recognized');
      emit(StudentNotRecognized());
    } else {
      print('attendance marked for student : $student');
      emit(AttendanceMarked(studentList: [student]));
    }
  }

  void disposeIsolate() {
    _isolateUtils.dispose();
  }

  Map<String, dynamic>? get inferenceResults {
    _modelInferenceService.inferenceResults;
    return null;
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
}
