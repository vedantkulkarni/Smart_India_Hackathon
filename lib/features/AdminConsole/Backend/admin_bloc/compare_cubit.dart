import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

part 'compare_state.dart';

class CompareCubit extends Cubit<CompareState> {
  final AWSApiClient awsApiClient;
  late List<ClassRoom> classRoomList;
  CompareCubit({required this.awsApiClient}) : super(CompareInitial()) {
    listClassRooms(schoolID: 'schoolID');
  }

  Future<void> listClassRooms({required String schoolID}) async {
    classRoomList = await awsApiClient.getListOfClassrooms(limit: 10);
    emit(ClassRoomsFetched());
  }

  Future<void> compare({required String classRoomID}) async {
    emit(CompareInitial());
    // await awsApiClient.compare(classRoomID: classRoomID);
    emit(CompareDone());
  }
}
