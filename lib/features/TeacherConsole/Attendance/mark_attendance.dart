import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';

import '../../../injection_container.dart';
import 'camera_service.dart';
import 'face_detector.dart';
import 'ml_algo.dart';

class MarkAttendnacePage extends StatefulWidget {
  MLService mlService;
  List<CameraDescription> cameras;
  MarkAttendnacePage({Key? key, required this.cameras, required this.mlService})
      : super(key: key);

  @override
  State<MarkAttendnacePage> createState() => _MarkAttendnacePageState(cameras);
}

class _MarkAttendnacePageState extends State<MarkAttendnacePage> {
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  bool _detectingFaces = false;
  bool pictureTaken = false;

  bool _initializing = false;

  bool _saving = false;
  bool _bottomSheetVisible = false;

  // service injection
  FaceDetectorService _faceDetectorService = getIt<FaceDetectorService>();
  CameraService _cameraService = getIt<CameraService>();

  final _cameras;
  _MarkAttendnacePageState(this._cameras);

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  _start() async {
    setState(() => _initializing = true);
    await _cameraService.initialize();
    _faceDetectorService.initialize();
    await widget.mlService.initialize();
    setState(() => _initializing = false);

    _frameFaces();
  }

  Future<bool> onShot() async {
    if (faceDetected == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('No face detected!'),
          );
        },
      );

      return false;
    } else {
      _saving = true;
      await Future.delayed(Duration(milliseconds: 500));
      // await _cameraService.cameraController?.stopImageStream();
      await Future.delayed(Duration(milliseconds: 200));
      XFile? file = await _cameraService.takePicture();
      imagePath = file?.path;

      setState(() {
        _bottomSheetVisible = true;
        pictureTaken = true;
      });

      return true;
    }
  }

  _frameFaces() {
    imageSize = _cameraService.getImageSize();

    _cameraService.cameraController?.startImageStream((image) async {
      if (_cameraService.cameraController != null) {
        if (_detectingFaces) return;

        _detectingFaces = true;

        try {
          await _faceDetectorService.detectFacesFromImage(image);

          if (_faceDetectorService.faces.isNotEmpty) {
            setState(() {
              faceDetected = _faceDetectorService.faces[0];
            });
            if (_saving) {
              widget.mlService.setCurrentPrediction(image, faceDetected);
              setState(() {
                _saving = false;
              });
            }
          } else {
            setState(() {
              faceDetected = null;
            });
          }

          _detectingFaces = false;
        } catch (e) {
          print(e);
          _detectingFaces = false;
        }
      }
    });
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    setState(() {
      _bottomSheetVisible = false;
      pictureTaken = false;
    });
    this._start();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _cameraService.cameraController == null
          ? Container()
          : CameraPreview(_cameraService.cameraController!),
      _cameraService.cameraController == null?Container(
        
      ):CameraUIOverlay(
        cameraController: _cameraService.cameraController!,
      )
    ]);
  }
}

class CameraUIOverlay extends StatefulWidget {
  final CameraController cameraController;
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
      body: Container(
          child: Column(
        children: [
          const Spacer(),
          FloatingActionButton(
            backgroundColor: backgroundColor,
            onPressed: () async {},
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
      )),
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
        builder: (context, state) {
          if (state is AttendanceInitial || state is ScanningAttendance) {
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
          } else if (state is ComparingResults) {
            return progressIndicator;
          }
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
                                      color: greyColor, fontFamily: 'Poppins'),
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
                              onPressed: () {}, icon: const Icon(Icons.check)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.delete))
                        ],
                      )
                    ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
