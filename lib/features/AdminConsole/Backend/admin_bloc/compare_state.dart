part of 'compare_cubit.dart';

abstract class CompareState extends Equatable {
  const CompareState();

  @override
  List<Object> get props => [];
}

class CompareInitial extends CompareState {}
class StartCompare extends CompareState {}
class CompareDone extends CompareState {}
class ClassRoomsFetched extends CompareState {}
