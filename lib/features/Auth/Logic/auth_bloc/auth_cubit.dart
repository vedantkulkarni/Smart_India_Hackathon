import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AWSApiClient awsApiClient;
  String username;
  String password;
  AuthCubit({required this.awsApiClient, required this.username, required this.password}) : super(AuthInitial()) {
    authenticateUser(email: username, password: password);
  }

  String authUserEmail = '';

  Future<void> authenticateUser(
      {required String email, required String password}) async {
    await awsApiClient.authenticateUser(email: email, password: password);
    authUserEmail = email;
    emit(Authenticated());
  }

  String get email {
    return authUserEmail;
  }
}
