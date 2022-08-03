part of 'class_details_cubit.dart';

abstract class ClassDetailsState extends Equatable {
  const ClassDetailsState();

  @override
  List<Object> get props => [];
}

class ClassDetailsInitial extends ClassDetailsState {}
class LoadingClassDetails extends ClassDetailsState {}
class ClassRoomDetialsFetched extends ClassDetailsState {}
