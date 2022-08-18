import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mediapipe/model_inference_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import '../../../core/constants.dart';
import 'camera_service.dart';
import 'face_detector.dart';
import 'face_painter.dart';
import 'mediapipe/face_detection_painter.dart';

class CameraDetectionPreview extends StatelessWidget {
  CameraDetectionPreview({Key? key}) : super(key: key);

  final CameraService _cameraService = getIt<CameraService>();
  final FaceDetectorService _faceDetectorService = getIt<FaceDetectorService>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final modelInferenceService = getIt<ModelInferenceService>();
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        if (state is InitializingCamera) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Container(
              child: const Center(child: Text('Initializing Services')),
            ),
          );
        }
        if (_cameraService.cameraController == null) {
          return Container(
            child: const Center(child: Text('Only a few steps left !')),
          );
        }

        var bbox =
            BlocProvider.of<AttendanceCubit>(context).inferenceResults?['bbox'];
        var _ratio =  
            MediaQuery.of(context).size.width/
        BlocProvider.of<AttendanceCubit>(context)
            .cameraService
            .cameraController!
            .value.previewSize!.height ;
        if (BlocProvider.of<AttendanceCubit>(context).isPredicting == false) {
          BlocProvider.of<AttendanceCubit>(context)
              .startPredictingMediaPipe(context);
        }

        if (state is FacesDetected) {
          Rect? face = (state).rect;

          return Stack(
            
            children: <Widget>[
              CameraPreview(_cameraService.cameraController!),
              if (modelInferenceService.inferenceResults != null)
                _ModelPainter(
                  customPainter: FaceDetectionPainter(
                    bbox: face ?? Rect.zero,
                    ratio: _ratio,
                  ),
                )
            ],
          );
        }
        return Container(
          child: const Center(child: Text("HI")),
        );
      },
    );
  }
}

class _ModelPainter extends StatelessWidget {
  const _ModelPainter({
    required this.customPainter,
    Key? key,
  }) : super(key: key);

  final CustomPainter customPainter;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: customPainter,
    );
  }
}
