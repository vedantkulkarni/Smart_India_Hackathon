import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AWSApiClient awsApiClient;
  AdminCubit({required this.awsApiClient}) : super(AdminInitial());

  Future<void> getAdminDetails({required String userID}) async {
    awsApiClient.getAdminDetails();
  }
}
