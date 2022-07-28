part of 'admin_cubit.dart';

@immutable
abstract class AdminState {}


//Admin
class AdminInitial extends AdminState {}
class AdminDetailsFetched extends AdminState {}
class AdminDetailsUpdated extends AdminState {}


//School
class NoSchoolSet extends AdminState {}
class SchoolDetailsFetched extends AdminState {}
class SchoolNotFound extends AdminState {}
class CreatingSchool extends AdminState {}
class SchoolCreated extends AdminState {}
