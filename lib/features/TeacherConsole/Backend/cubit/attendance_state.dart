part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class ScanningAttendance extends AttendanceState {}
class ComparingResults extends AttendanceState {}

class AttendanceMarked extends AttendanceState {
  Student student;
  AttendanceMarked({required this.student});
}