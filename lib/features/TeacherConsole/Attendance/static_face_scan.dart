import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mediapipe/face_detection_painter.dart';

class StaticFaceScan extends StatefulWidget {
  const StaticFaceScan({Key? key}) : super(key: key);

  @override
  State<StaticFaceScan> createState() => _StaticFaceScanState();
}

class _StaticFaceScanState extends State<StaticFaceScan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Container(
          color: whiteColor,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
        CustomPaint(
          painter: FaceDetectionPainter(
              bbox: const Rect.fromLTRB(30, 100, 60, 30), ratio: 1),
        )
      ]),
    );
  }
}
