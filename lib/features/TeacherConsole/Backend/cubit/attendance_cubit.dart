import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

import '../../../../models/Student.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AWSApiClient apiClient;
  // final ClassRoom classRoom;
  AttendanceCubit({required this.apiClient}) : super(AttendanceInitial());
}
