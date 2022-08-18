import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/cam_detection_preview.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/camera_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_detector.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/ml_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../injection_container.dart';

class AddStudentFacialData extends StatefulWidget {
  List<CameraDescription> cameras;
  Student student;
  MLService mlService;
  AddStudentFacialData(
      {Key? key,
      required this.cameras,
      required this.student,
      required this.mlService})
      : super(key: key);

  @override
  State<AddStudentFacialData> createState() =>
      _AddStudentFacialDataState(cameras);
}

class _AddStudentFacialDataState extends State<AddStudentFacialData> {
  final _cameras;
  final _cameraService = getIt<CameraService>();
  final FaceDetectorService _faceDetectorService = getIt<FaceDetectorService>();
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  final bool _detectingFaces = false;
  bool pictureTaken = false;

  bool _initializing = false;

  final bool _saving = true;
  final bool _bottomSheetVisible = false;
  _AddStudentFacialDataState(this._cameras);

  @override
  void initState() {
    super.initState();
    // _start();
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

    // _frameFaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(children: [
        CameraDetectionPreview(),
        _cameraService.cameraController == null
            ? Container()
            : AddFaceCamOverLay(
                cameraController: _cameraService.cameraController!,
                student: widget.student,
              )
      ])),
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
        // if (state is ComparingResults) {
        //   return progressIndicator;
        // } else if (state is StudentNotRecognized) {
        //   return Container(
        //     child: const Center(child: Text('Student not recognized')),
        //   );
        // }
        return Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                height: 40,
                width: 200,
                child: CustomTextButton(
                    onPressed: () {
                      attendanceCubit.addStudentFacialDataToDatabase(
                          student: widget.student);
                    },
                    text: 'Uplaod to Database'),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 140,
                child: CustomTextButton(
                    onPressed: () {
                      attendanceCubit.startPredictingMediaPipe(context);
                    },
                    text: 'Start'),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        );
      },
    );
  }
}
