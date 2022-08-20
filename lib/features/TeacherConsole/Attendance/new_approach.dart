import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/attendance_card.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';

class FaceVerifyScreen extends StatefulWidget {
  const FaceVerifyScreen({Key? key}) : super(key: key);

  @override
  State<FaceVerifyScreen> createState() => _FaceVerifyScreenState();
}

class _FaceVerifyScreenState extends State<FaceVerifyScreen> {
  final ImagePicker _picker = ImagePicker();
  Future<InputImage> pickImage() async {
    // Pick an image
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 15);
    InputImage inputImage = InputImage.fromFile(File(photo!.path));

    return inputImage;
  }

  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return Scaffold(
      body: Container(
          child: Center(
        child: CustomTextButton(
          onPressed: () async {
            var inputImage = await pickImage();
          Face face =  await attendanceCubit.detectFaceFromImage(inputImage);
            await attendanceCubit.setCurrentPrediction(detectedFace:face);
            await attendanceCubit.compareDetectedResults();
          },
          text: 'Pick',
        ),
      )),
    );
  }
}
