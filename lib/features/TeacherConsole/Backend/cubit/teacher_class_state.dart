part of 'teacher_class_cubit.dart';

abstract class TeacherClassState extends Equatable {
  const TeacherClassState();

  @override
  List<Object> get props => [];
}

class TeacherClassInitial extends TeacherClassState {}
class ClassDetailsFetched extends TeacherClassState {}
