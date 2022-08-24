part of 'class_details_cubit.dart';

abstract class ClassDetailsState {
  const ClassDetailsState();

  @override
  List<Object> get props => [];
}

class ClassDetailsInitial extends ClassDetailsState {}

class LoadingClassDetails extends ClassDetailsState {}

class ClassRoomDetialsFetched extends ClassDetailsState {}

class FectingAttendanceByDate extends ClassDetailsState {}

class AttendanceByDateFetched extends ClassDetailsState {}

class FetchingAttendanceList extends ClassDetailsState {}

class AttendanceListFetched extends ClassDetailsState {}
