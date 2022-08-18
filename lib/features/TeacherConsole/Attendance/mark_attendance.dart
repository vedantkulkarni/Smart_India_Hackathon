import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/cam_detection_preview.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';

import '../../../injection_container.dart';
import 'camera_service.dart';
import 'face_detector.dart';
import 'mediapipe/face_detection_painter.dart';
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

  final bool _detectingFaces = false;
  bool pictureTaken = false;

  final bool _initializing = false;

  bool _saving = true;
  bool _bottomSheetVisible = false;

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

  // _start() async {
  //   setState(() => _initializing = true);
  //   await _cameraService.initialize();
  //   _faceDetectorService.initialize();
  //   await widget.mlService.initialize();
  //   setState(() => _initializing = false);

  //   // _frameFaces();
  // }

  Future<bool> onShot() async {
    if (faceDetected == null) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('No face detected!'),
          );
        },
      );

      return false;
    } else {
      _saving = true;
      await Future.delayed(const Duration(milliseconds: 500));
      // await _cameraService.cameraController?.stopImageStream();
      await Future.delayed(const Duration(milliseconds: 200));
      XFile? file = await _cameraService.takePicture();
      imagePath = file?.path;

      setState(() {
        _bottomSheetVisible = true;
        pictureTaken = true;
      });

      return true;
    }
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    setState(() {
      _bottomSheetVisible = false;
      pictureTaken = false;
    });
    // _start();
  }

  late double _ratio;

  @override
  Widget build(BuildContext context) {


   
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        

        return Stack(children: [
          CameraDetectionPreview(),
          // CameraUIOverlay(cameraController: _cameraService.cameraController)
        ]);
      },
    );
  }
}

// Widget get _drawBoundingBox {

//   return _ModelPainter(
//     customPainter: FaceDetectionPainter(
//       bbox: bbox ?? Rect.zero,
//       ratio: _ratio,
//     ),
//   );
//   // return Container();
// }

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
          if (state is ComparingResults) {
            return progressIndicator;
          } else if (state is StudentNotRecognized) {
            return Container(
              child: const Center(child: Text('Student not recognized')),
            );
          } else if (state is InitializingMLModel) {
            return Column(
              children: [
                const Spacer(),
                Container(
                    color: backgroundColor,
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: progressIndicator),
              ],
            );
          }

          return Container(
              child: Column(
            children: [
              const Spacer(),
              FloatingActionButton(
                backgroundColor: backgroundColor,
                onPressed: () {
                  attendanceCubit.compareDetectedResults();
                },
                child: const Icon(
                  Icons.start,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              FloatingActionButton(
                backgroundColor: backgroundColor,
                onPressed: () {
                  attendanceCubit.startPredicting();
                },
                child: const Icon(
                  Icons.camera_alt,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: const AttendanceMarkedForStudentWidget(),
              )
            ],
          ));
        },
      ),
    );
  }
}

class AttendanceMarkedForStudentWidget extends StatefulWidget {
  // final Student?? student;
  const AttendanceMarkedForStudentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceMarkedForStudentWidget> createState() =>
      _AttendanceMarkedForStudentWidgetState();
}

class _AttendanceMarkedForStudentWidgetState
    extends State<AttendanceMarkedForStudentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<AttendanceCubit, AttendanceState>(
        // buildWhen: (previous, current) {
        //   if (previous is AttendanceMarked) {
        //     return false;
        //   } else if (current is CurrentPredictionSet) {
        //     return false;
        //   }
        //   return true;
        // },
        builder: (context, state) {
          if (state is AttendanceInitial) {
            return progressIndicator;
          } else if (state is ScanningAttendance ||
              state is MLModelInitialized) {
            return Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/faceRecog.json', height: 100),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        "Please scan the face of student to record their Attendance",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: lightTextColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                  ]),
            );
          } else if (state is InitializingMLModel) {
            return progressIndicator;
          } else if (state is StudentNotRecognized) {
            return const Center(
              child: Text("Student Not recognized"),
            );
          } else if (state is CurrentPredictionSet) {
            return const Center(
              child: Text("Calculated Face Data from Image Stream"),
            );
          } else if (state is NoFacesDetected) {
            return const Center(
              child: Text("No Faces Detected"),
            );
          } else if (state is FacesDetected) {
            return const Center(
              child: Text("Faces Detected\nPredicting Facial Data......"),
            );
          }
          if (state is AttendanceMarked) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Scan Results",
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
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
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
                              ),
                              radius: 35,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Vedant Dattatray Kulkarni",
                                style: TextStyle(
                                    color: blackColor,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '23317',
                                    style: TextStyle(
                                        color: greyColor,
                                        fontFamily: 'Poppins'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('|',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: 'Poppins')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Class 5A',
                                      style: TextStyle(
                                          color: greyColor,
                                          fontFamily: 'Poppins')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('|',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: 'Poppins')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Present',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: 'Poppins')),
                                ]),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.check)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete))
                          ],
                        )
                      ]),
                ),
              ],
            );
          }
          return Container(
            child: const Center(child: Text("Calculating")),
          );
        },
      ),
    );
  }
}
