import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_verify.dart';

import '../../../core/constants.dart';
import '../../../injection_container.dart';
import '../Backend/cubit/attendance_cubit.dart';
import '../Backend/cubit/teacher_class_cubit.dart';
import 'cam_detection_preview.dart';
import 'camera_service.dart';

class FaceVerifyWithProfileImage extends StatefulWidget {
  const FaceVerifyWithProfileImage({Key? key}) : super(key: key);

  @override
  State<FaceVerifyWithProfileImage> createState() =>
      _FaceVerifyWithProfileImageState();
}

class _FaceVerifyWithProfileImageState
    extends State<FaceVerifyWithProfileImage> {
  final CameraService _cameraService = getIt<CameraService>();
  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    final teacherClassCubit = BlocProvider.of<TeacherClassCubit>(context);
    return Stack(children: [
      CameraDetectionPreview(callback: () async {
        final file =
            await attendanceCubit.cameraService.cameraController!.takePicture();
        await attendanceCubit.cameraService.cameraController!.pausePreview();

        await showMaterialModalBottomSheet(
          context: context,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: teacherClassCubit),
              BlocProvider.value(value: attendanceCubit)
            ],
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                // child: FaceVerify(
                //   capturedImage: file,
                // )),
                child: Container(),)
          ),
        );
        await attendanceCubit.cameraService.cameraController!.resumePreview();
      }),
      // CameraUIOverlay(cameraController: _cameraService.cameraController)
    ]);
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ComparingResults) {
            return progressIndicator;
          } else if (state is StudentNotRecognized) {
            return Container(
              child: const Center(child: Text('Student not recognized')),
            );
          } else if (state is InitializingCamera) {
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
              Center(
                child: FloatingActionButton(
                  backgroundColor: backgroundColor,
                  onPressed: () async {
                    // attendanceCubit.compareDetectedResults();
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.25,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: const BoxDecoration(
              //       color: whiteColor,
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(10),
              //           topRight: Radius.circular(10))),
              //   child: const AttendanceMarkedForStudentWidget(),
              // )
            ],
          ));
        },
      ),
    );
  }
}
