part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class InitializingMLModel extends AttendanceState {}

class MLModelInitialized extends AttendanceState {}

class ScanningAttendance extends AttendanceState {}

class ComparingResults extends AttendanceState {}
class CurrentPredictionSet extends AttendanceState {}
class NoFacesDetected extends AttendanceState {}
class StudentNotRecognized extends AttendanceState {}
class FacesDetected extends AttendanceState {
  
}

class AttendanceMarked extends AttendanceState {
  Student student;
  AttendanceMarked({required this.student});
}

class FinalImage extends AttendanceState {
  Image image;
  FinalImage(this.image);
}
