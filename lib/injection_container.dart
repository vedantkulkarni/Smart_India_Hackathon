import 'package:get_it/get_it.dart';
import 'package:team_dart_knights_sih/core/attendance_upload_service.dart';
import 'package:team_dart_knights_sih/core/platform_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/role_checker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mediapipe/face_detection_service.dart';

import 'features/TeacherConsole/Attendance/camera_service.dart';
import 'features/TeacherConsole/Attendance/face_detector.dart';
import 'features/TeacherConsole/Attendance/mediapipe/model_inference_service.dart';
import 'features/TeacherConsole/Attendance/ml_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => PlatformChecker());
  getIt.registerLazySingleton(() => RoleChecker());
  getIt.registerLazySingleton(() => AttendanceUploadService());
  getIt.registerLazySingleton<AWSApiClient>(() => AWSApiClientImpl());
  getIt.registerLazySingleton<CameraService>(() => CameraService());
  
  getIt.registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  getIt.registerLazySingleton<ModelInferenceService>(() => ModelInferenceService());
  getIt.registerLazySingleton<FaceDetection>(() => FaceDetection());
}
