import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AWSApiClient awsApiClient;
  AuthCubit({required this.awsApiClient}) : super(AuthInitial());

  Future<void> authenticateUser(
      {required String email, required String password}) async {
    await awsApiClient.authenticateUser(email: email, password: password);
    emit(Authenticated());
  }
}
