import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_detector.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/ml_algo.dart';

import '../../../../models/Student.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AWSApiClient apiClient;
  final FaceDetectorService faceDetectorService;
  final MLService mlService;

  // final ClassRoom classRoom;
  AttendanceCubit(
      {required this.apiClient,
      required this.faceDetectorService,
      required this.mlService})
      : super(AttendanceInitial()) {
    faceDetectorService.initialize();
    initializeInterPreter();
  }

  Future<void> initializeInterPreter() async {
    emit(InitializingMLModel());
    await mlService.initialize();
    print("model initializedb");
    emit(MLModelInitialized());
  }

  // Future<void> processStudentCapture({required XFile? captureImage}) async {
  //   Image image = Image.file(File(captureImage!.path));
  //   final path = captureImage.path;
  //   final bytes = await File(path).readAsBytes();
  //   final img.Image finalImage = img.decodeImage(bytes)!;
  //   InputImage inputImage = InputImage.fromFile(File(captureImage.path));

  //   await faceDetectorService.detectFacesFromImage(inputImage);
  //   mlService.setCurrentPrediction(finalImage, faceDetectorService.faces[0]);
  //   print(mlService.predictedData);
  //   final predictedStudent = await mlService.predict();
  //   print(predictedStudent);
  // }

  // Future<void> addFaceDataToStudent(
  //     {required XFile? captureImage, required Student student}) async {
  //   Image image = Image.file(File(captureImage!.path));
  //   final path = captureImage.path;
  //   final bytes = await File(path).readAsBytes();
  //   final img.Image finalImage = img.decodeImage(bytes)!;
  //   InputImage inputImage = InputImage.fromFile(File(captureImage.path));
  //   await faceDetectorService.detectFacesFromImage(inputImage);
  //   mlService.setCurrentPrediction(finalImage, faceDetectorService.faces[0]);
  //   List<dynamic> modelData = mlService.predictedData;
  //   print(modelData[0].runtimeType);
  //   final updatedStudent =
  //       student.copyWith(modelData: modelData as List<double>);
  //   final result =
  //       await apiClient.updateStudent(updatedStudent: updatedStudent);
  //   print(result);
  // }
}
