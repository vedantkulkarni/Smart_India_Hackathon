import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';

class FaceRecognitionAttendance extends StatefulWidget {
  const FaceRecognitionAttendance({Key? key}) : super(key: key);

  @override
  State<FaceRecognitionAttendance> createState() =>
      _FaceRecognitionAttendanceState();
}

class _FaceRecognitionAttendanceState extends State<FaceRecognitionAttendance> {
  File? file1;
  File? file2;

  final options = FaceDetectorOptions(enableLandmarks: true);

  Future<void> _detectFace(File file) async {
    InputImage image = InputImage.fromFile(file);
    final faceDetector = FaceDetector(options: options);
    final List<Face> faces = await faceDetector.processImage(image);
    print(faces[0].landmarks);
  }

  // Future<void> _setCurrentPrediction( CameraImage cameraImage,Face face)async
  // {

  // }

  Future<File> _pickMyFileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      final file = File(result.files.first.path!);
      return file;
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<TeacherClassCubit>(context).fetchClassRoomDetailsForTeacher(
    //     classRoomID: '29d318a3-f09b-4675-bfb0-a73eb7c5dbbd');
    return Scaffold(
      body: Container(
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          const Text("hello"),
          Container(
            color: primaryColor.withOpacity(0.1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                file1 == null
                    ? Center(
                        child: CustomTextButton(
                            onPressed: () async {
                              file1 = await _pickMyFileImage();
                              setState(() {});
                            },
                            text: 'Pick File'),
                      )
                    : SizedBox(
                        height: 200, width: 200, child: Image.file(file1!)),
                file2 == null
                    ? Center(
                        child: CustomTextButton(
                            onPressed: () async {
                              file2 = await _pickMyFileImage();
                              setState(() {});
                            },
                            text: 'Pick File'),
                      )
                    : SizedBox(
                        height: 200, width: 200, child: Image.file(file2!))
              ],
            ),
          ),
          CustomTextButton(
              onPressed: () async {
                await _detectFace(file1!);
              },
              text: 'Detect')
        ]),
      ),
    );
  }
}
