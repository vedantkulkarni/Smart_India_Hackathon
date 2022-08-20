import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/cam_detection_preview.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/camera_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/ml_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/custom_snackbar.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../core/constants.dart';
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
  State<AddStudentFacialData> createState() => _AddStudentFacialDataState();
}

class _AddStudentFacialDataState extends State<AddStudentFacialData> {
  final _cameraService = getIt<CameraService>();

  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  _AddStudentFacialDataState();

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

  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return Scaffold(
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) async {
          if (state is CurrentPredictionSet) {
            
            bool res = await showModalBottomSheet(
                context: context,
                builder: (_) => BlocProvider.value(
                      value: attendanceCubit,
                      child: AddFaceCamOverLay(
                        cameraController: _cameraService.cameraController!,
                        student: widget.student,
                      ),
                    ));
            if (res) {
              Navigator.pop(context);
              showSnackBar(context, text: 'Face Added');
            } else {
              _cameraService.cameraController!.resumePreview();
            }
          }
        },
        builder: (context, state) {
          if (state is InitializingCamera || state is InitializingMLModel) {
            return Scaffold(
              backgroundColor: backgroundColor,
              body: Container(
                child: const Center(child: Text('Initializing Services')),
              ),
            );
          }
          return Container(
              child: Stack(children: [
            CameraDetectionPreview(),
            // _cameraService.cameraController == null
            //     ? Container()
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                  child: FloatingActionButton.large(
                    onPressed: () async {
                      attendanceCubit.cameraService.cameraController!
                          .pausePreview();
                      attendanceCubit.setCurrentPrediction();
                      // await attendanceCubit.compareDetectedResults();
                    },
                    backgroundColor: primaryColor,
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: whiteColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ]));
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
                      Navigator.pop(context, true);
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
