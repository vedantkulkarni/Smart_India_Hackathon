part of 'attendance_cubit.dart';

abstract class AttendanceState {
  const AttendanceState();
}

class AttendanceInitial extends AttendanceState {}

class InitializingMLModel extends AttendanceState {}

class MLModelInitialized extends AttendanceState {}

class StartingImageStream extends AttendanceState {}

class ComparingResults extends AttendanceState {}

class CurrentPredictionSet extends AttendanceState {}

class NoFacesDetected extends AttendanceState {}

class StudentNotRecognized extends AttendanceState {}
class AddingFacialDataToDataBase extends AttendanceState {}
class FacialDataAdded extends AttendanceState {}



class FacesDetected extends AttendanceState {
  Rect? rect;
  CameraImage cameraImage;
  FacesDetected(this.cameraImage,this.rect);
}

class InitializingCamera extends AttendanceState {}

class CameraInitialized extends AttendanceState {}

class InitializedAllServices extends AttendanceState {}

class StudentNotSelected extends AttendanceState {}

class StudentSelected extends AttendanceState {
  final Student student;
  StudentSelected({required this.student});
}

class UploadingAttendance extends AttendanceState {}

class AttendanceUploaded extends AttendanceState {}

class AttendanceMarked extends AttendanceState {
  Student student;
  AttendanceMarked({required this.student});
}

class AttendanceToggled extends AttendanceState {
  Map<String, AttendanceStatus> attendance;
  AttendanceToggled({required this.attendance});
}

class FinalImage extends AttendanceState {
  Image image;
  FinalImage(this.image);
}
