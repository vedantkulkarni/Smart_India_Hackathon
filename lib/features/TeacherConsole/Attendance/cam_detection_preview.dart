import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mediapipe/model_inference_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import '../../../core/constants.dart';
import 'camera_service.dart';
import 'mediapipe/face_detection_painter.dart';

class CameraDetectionPreview extends StatelessWidget {
  CameraDetectionPreview({Key? key}) : super(key: key);

  final CameraService _cameraService = getIt<CameraService>();
  final ModelInferenceService _modelInferenceService =
      getIt<ModelInferenceService>();
  Rect? face;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final modelInferenceService = getIt<ModelInferenceService>();
    return BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
      if (state is InitializedAllServices) {
        BlocProvider.of<AttendanceCubit>(context)
            .startPredictingMediaPipe(context);
      }
    }, builder: (context, state) {
      if (state is InitializingCamera || state is InitializingMLModel) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Container(
            child: const Center(child: Text('Initializing Services')),
          ),
        );
      }
      face = _modelInferenceService.inferenceResults?['bbox'];

      return Stack(
        children: <Widget>[
          CameraPreview(_cameraService.cameraController!),
          _ModelPainter(
            customPainter: FaceDetectionPainter(
              bbox: face ?? Rect.zero,
              ratio: 1,
            ),
          ),
        ],
      );
    });
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
