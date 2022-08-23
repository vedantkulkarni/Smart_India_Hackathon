import 'package:flutter/material.dart';

class FaceDetectionPainter extends CustomPainter {
  final Rect bbox;
   double ratio;

  FaceDetectionPainter({
    required this.bbox,
    required this.ratio,
  });

  @override
  void paint(Canvas canvas, Size size) {
   
    if (bbox != Rect.zero) {
      var paint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawRect(bbox, paint);
      // canvas.drawOval(bbox, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
