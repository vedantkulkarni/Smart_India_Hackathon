import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import '../../../core/constants.dart';
import 'camera_service.dart';
import 'face_detector.dart';
import 'face_painter.dart';

class CameraDetectionPreview extends StatelessWidget {
  CameraDetectionPreview({Key? key}) : super(key: key);

  final CameraService _cameraService = getIt<CameraService>();
  final FaceDetectorService _faceDetectorService = getIt<FaceDetectorService>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        if (state is InitializingMLModel) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Container(
              child: const Center(child: Text('Initializing Services')),
            ),
          );
        }

        return Transform.scale(
          scale: 1.0,
          child: AspectRatio(
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: SizedBox(
                  width: width,
                  height: width *
                      _cameraService.cameraController!.value.aspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CameraPreview(_cameraService.cameraController!),
                      if (_faceDetectorService.faceDetected)
                        CustomPaint(
                          painter: FacePainter(
                            face: _faceDetectorService.faces[0],
                            imageSize: _cameraService.getImageSize(),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
