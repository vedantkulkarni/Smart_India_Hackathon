import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

import 'ai_model.dart';
import 'face_detection_service.dart';
import 'isolate_utils.dart';


enum Models {
  FaceDetection,
  FaceMesh,
  Hands,
  Pose,
}

class ModelInferenceService {
  late AiModel model;
  late Function handler;
  Map<String, dynamic>? inferenceResults;

  Future<Map<String, dynamic>?> inference({
    required IsolateUtils isolateUtils,
    required CameraImage cameraImage,
  }) async {
    final responsePort = ReceivePort();

    isolateUtils.sendMessage(
      handler: handler,
      params: {
        'cameraImage': cameraImage,
        'detectorAddress': model.getAddress,
      },
      sendPort: isolateUtils.sendPort,
      responsePort: responsePort,   
    );

    inferenceResults = await responsePort.first;
    responsePort.close();
  }

  void setModelConfig(int index) {
   
     
        model = getIt<FaceDetection>();
        handler = runFaceDetector;
        
     
    }
  }

