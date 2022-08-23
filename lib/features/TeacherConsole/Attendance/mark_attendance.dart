import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:image/image.dart' as imglib;
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/cam_detection_preview.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/custom_snackbar.dart';
import 'package:team_dart_knights_sih/models/AttendanceStatus.dart';

import '../../../models/AttendanceStatus.dart';
import '../../../injection_container.dart';
import '../../../models/Student.dart';
import 'camera_service.dart';
import 'face_detector.dart';
import 'ml_service.dart';

class MarkAttendnacePage extends StatefulWidget {
  MLService mlService;

  MarkAttendnacePage({Key? key, required this.mlService}) : super(key: key);

  @override
  State<MarkAttendnacePage> createState() => _MarkAttendnacePageState();
}

class _MarkAttendnacePageState extends State<MarkAttendnacePage> {
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
    showModalBottomSheet<Student?>(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: cubit,
            child: WorkOnImageWidget(
              capturedImage: xfile,
            ),
          );
        }).then((value) async {
      if (value == null) {
        _cameraService.cameraController!.resumePreview();
      } else {
        print("Attendance Has been marked");
        cubit.attendanceMap[value.studentID] = AttendanceStatus.Present;
        showSnackBar(context,
            text: 'Attendance marked for ${value.studentName}');
        _cameraService.cameraController!.resumePreview();
      }
    });

    imglib.Image? capturedImage = imglib.decodeImage(await xfile.readAsBytes());
    // //For Firebase Ml Kit face detection
    InputImage inputImage = InputImage.fromFile(File(xfile.path));
    Face face = await cubit.detectFaceFromImage(inputImage);

    await cubit.setCurrentPrediction(detectedFace: face, image: capturedImage);
    await cubit.compareDetectedResults();
  }

  @override
  Widget build(BuildContext context) {
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

class AttendanceMarkedForStudentWidget extends StatefulWidget {
  final Student student;
  const AttendanceMarkedForStudentWidget({Key? key, required this.student})
      : super(key: key);

  @override
  State<AttendanceMarkedForStudentWidget> createState() =>
      _AttendanceMarkedForStudentWidgetState();
}

class _AttendanceMarkedForStudentWidgetState
    extends State<AttendanceMarkedForStudentWidget> {
  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Scan Results",
                style: TextStyle(
                    color: primaryColor,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: textFieldFillColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.student.profilePhoto ??
                                'https://avatars.githubusercontent.com/u/24658039?v=4',
                          ),
                          radius: 35,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.student.studentName,
                            style: const TextStyle(
                                color: blackColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.student.roll.toString(),
                                style: const TextStyle(
                                    color: greyColor, fontFamily: 'Poppins'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('|',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins')),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Class 5A',
                                  style: TextStyle(
                                      color: greyColor, fontFamily: 'Poppins')),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('|',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins')),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Present',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins')),
                            ]),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              attendanceCubit
                                      .attendanceMap[widget.student.studentID] =
                                  AttendanceStatus.Present;
                              Navigator.pop(context, widget.student);
                            },
                            icon: const Icon(Icons.check)),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    )
                  ]),
            ),
          ],
        ));
  }
}

class WorkOnImageWidget extends StatefulWidget {
  XFile capturedImage;
  WorkOnImageWidget({Key? key, required this.capturedImage}) : super(key: key);

  @override
  State<WorkOnImageWidget> createState() => _WorkOnImageWidgetState();
}

class _WorkOnImageWidgetState extends State<WorkOnImageWidget> {
  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: Image.file(
              File(widget.capturedImage.path),
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.height * 0.20,
              fit: BoxFit.cover,
            ).image,
          ),
          BlocConsumer<AttendanceCubit, AttendanceState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is AttendanceMarked) {}
            },
            builder: (context, state) {
              if (state is StudentNotRecognized) {
                return Container(
                  child: Column(
                    children: [
                      const Text('Student not recognized!',
                          style: TextStyle(
                              color: greyColor,
                              fontFamily: 'Poppins',
                              fontSize: 18)),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'Try Again')
                    ],
                  ),
                );
              } else if (state is AttendanceMarked) {
                return AttendanceMarkedForStudentWidget(
                  student: (state.student),
                );
              }
              return SizedBox(
                // width: double,
                child: Lottie.network(
                    'https://lottie.host/0782b1ca-744f-4fe3-89d7-10d8525fcccb/acXE04O3xt.json',
                    width: MediaQuery.of(context).size.width * 0.5),
              );
            },
          )
        ],
      ),
    );
  }
}
