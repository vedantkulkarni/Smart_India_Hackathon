import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_face_api/face_api.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';

class LivenessDetectionScreen extends StatefulWidget {
  LivenessDetectionScreen({Key? key}) : super(key: key);

  @override
  State<LivenessDetectionScreen> createState() =>
      _LivenessDetectionScreenState();
}

class _LivenessDetectionScreenState extends State<LivenessDetectionScreen> {
  String liveness = 'Check Liveness';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Liveness Detect'),
          Text(liveness),
          CustomTextButton(
              onPressed: () async {
                
                FaceSDK.startLiveness().then((livenessResponse) {
                  var response =
                      LivenessResponse.fromJson(json.decode(livenessResponse));

                  setState(() {
                    if (response!.liveness == LivenessStatus.PASSED) {
                      liveness = "Student liveness test passed";
                    } else {
                      liveness = "Liveness test failed";
                    }
                  });

                  // ... check response.liveness for detection result.
                });
              },
              text: 'Start')
        ],
      )),
    );
  }
}
