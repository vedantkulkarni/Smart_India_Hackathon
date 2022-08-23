import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:image/image.dart' as imglib;
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/cam_detection_preview.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/custom_snackbar.dart';
import 'package:team_dart_knights_sih/models/AttendanceStatus.dart';

import '../../../models/AttendanceStatus.dart';
import '../../../injection_container.dart';
import '../../../models/Student.dart';
import '../../AdminConsole/UI/widgets/custom_textbutton.dart';
import 'add_student_facial_data.dart';
import 'camera_service.dart';
import 'face_detector.dart';
import 'ml_service.dart';

class AddStudentFacialData extends StatefulWidget {
  MLService mlService;
  Student student;

  AddStudentFacialData(
      {Key? key, required this.mlService, required this.student})
      : super(key: key);

  @override
  State<AddStudentFacialData> createState() => _AddStudentFacialDataState();
}

class _AddStudentFacialDataState extends State<AddStudentFacialData> {
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  bool pictureTaken = false;

  // service injection
  final FaceDetectorService _faceDetectorService = getIt<FaceDetectorService>();
  final CameraService _cameraService = getIt<CameraService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cameraService.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // _cameraService.dispose();
    // BlocProvider.of<AttendanceCubit>(context).mlService.dispose();
    super.didChangeDependencies();
  }

  bool isSelect = false;
  bool isShow = false;

  Future<void> workOnCapturedImage(XFile xfile, BuildContext context) async {
    final cubit = BlocProvider.of<AttendanceCubit>(context);

    imglib.Image? capturedImage = imglib.decodeImage(await xfile.readAsBytes());
    // //For Firebase Ml Kit face detection
    InputImage inputImage = InputImage.fromFile(File(xfile.path));
    Face face = await cubit.detectFaceFromImage(inputImage);

    await cubit.setCurrentPrediction(detectedFace: face, image: capturedImage);
    var result = await showModalBottomSheet<Student?>(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: cubit,
            child: AddFaceCamOverLay(
              student: widget.student,
              cameraController: _cameraService.cameraController!,
            ),
          );
        });
    if (result == null) {
      _cameraService.cameraController!.resumePreview();
    } else {
     
      showSnackBar(context, text: 'Face Data Has been added');
      Navigator.pop(context,true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: blackColor,
          body: Stack(children: [
            CameraDetectionPreview(callback: () async {
              XFile? xfile =
                  await _cameraService.cameraController!.takePicture();
              _cameraService.cameraController!.pausePreview();
              workOnCapturedImage(xfile, context);
            }),

            // CameraUIOverlay(
            //   cameraController: attendanceCubit.cameraService.cameraController,
            // )
          ]),
        );
      },
    );
  }
}

class CameraUIOverlay extends StatefulWidget {
  final CameraController? cameraController;

  const CameraUIOverlay({Key? key, required this.cameraController})
      : super(key: key);

  @override
  State<CameraUIOverlay> createState() => _CameraUIOverlayState();
}

class _CameraUIOverlayState extends State<CameraUIOverlay> {
  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          // return Container(child:  AttendanceMarkedForStudentWidget());
          return Container();
        },
      ),
    );
  }
}

class AddFaceCamOverLay extends StatefulWidget {
  final CameraController cameraController;
  Student student;
  AddFaceCamOverLay(
      {Key? key, required this.cameraController, required this.student})
      : super(key: key);

  @override
  State<AddFaceCamOverLay> createState() => _AddFaceCamOverLayState();
}

class _AddFaceCamOverLayState extends State<AddFaceCamOverLay> {
  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        if (state is AddingFacialDataToDataBase) {
          return progressIndicator;
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 200,
                child: CustomTextButton(
                    onPressed: () async {
                      await attendanceCubit.addStudentFacialDataToDatabase(
                          student: widget.student);
                      Navigator.pop(context, widget.student);
                    },
                    text: 'Add Face'),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 200,
                child: CustomTextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    text: 'Try Again'),
              ),
            ],
          ),
        );
      },
    );
  }
}
