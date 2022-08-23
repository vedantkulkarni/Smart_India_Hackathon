import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import '../../../core/constants.dart';
import 'camera_service.dart';

class CameraDetectionPreview extends StatelessWidget {
  VoidCallback callback;
  CameraDetectionPreview({Key? key, required this.callback});
  final CameraService _cameraService = getIt<CameraService>();

  Rect? face;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
      // if (state is InitializedAllServices) {
      //   BlocProvider.of<AttendanceCubit>(context)
      //       .startPredictingMediaPipe(context);
      // }
    }, builder: (context, state) {
      if (state is InitializingCamera || state is InitializingMLModel) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Container(
            child: const Center(child: Text('Initializing Services')),
          ),
        );
      }
      // face = _modelInferenceService.inferenceResults?['bbox'];

      return Container(
        child: Stack(
          children: <Widget>[
            CameraPreview(_cameraService.cameraController!),
            CustomPaint(
              painter: OvalPainter(),
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 60),
                    child: CircleAvatar(
                      backgroundColor: greyColor,
                      radius: 36,
                      child: CircleAvatar(
                        backgroundColor: whiteColor,
                        radius: 34,
                        child: ElevatedButton(
                          onPressed: callback,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.transparent,
                            size: 34,
                          ),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0.0),
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all(
                                whiteColor), // <-- Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return greyColor.withOpacity(0.2);
                              }
                              return null; // <-- Splash color
                            }),
                          ),
                        ),
                      ),
                    )),
              ),
            ),

            // _ModelPainter(
            //   customPainter: FaceDetectionPainter(
            //     bbox: face ?? Rect.zero,
            //     ratio: 1,
            //   ),
            // ),
          ],
        ),
      );
    });
  }
}

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Method to convert degree to radians
    num degToRad(num deg) => deg * (3.14 / 180.0);

    Path path = Path();
    //Vertical line
    path.moveTo(size.width / 2, size.height / 8);
    path.lineTo(size.width / 2, (7 * size.height / 8) - 70);

    //Horizontal Line
    path.moveTo(100, (size.height / 2) - 50);
    path.lineTo(size.width - 100, (size.height / 2) - 50);

    //Right one
    path.moveTo(size.width - 50, size.height / 4);
    path.quadraticBezierTo(
        size.width - 50, size.height / 8, size.width - 100, size.height / 8);

    //Left one
    path.moveTo(50, size.height / 4);
    path.quadraticBezierTo(50, size.height / 8, 100, size.height / 8);

    // Bottom Right
    path.moveTo(size.width - 50, (3 * size.height / 4) - 70);
    path.quadraticBezierTo(size.width - 50, (7 * size.height / 8) - 70,
        size.width - 100, (7 * size.height / 8) - 70);

    // Bottom Left
    path.moveTo(50, (3 * size.height / 4) - 70);
    path.quadraticBezierTo(
        50, (7 * size.height / 8) - 70, 100, (7 * size.height / 8) - 70);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
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
