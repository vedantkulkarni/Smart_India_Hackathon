import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

import '../../../../models/User.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AWSApiClient awsApiClient;
  String userID;
  late User adminUser;
  AdminCubit({required this.awsApiClient, required this.userID})
      : super(AdminInitial()) {
    getAdminDetails(userID: userID);
  }

  Future<void> getAdminDetails({required String userID}) async {
    adminUser = await awsApiClient.getAdminDetails();
    emit(AdminDetailsFetched());
  }
}
