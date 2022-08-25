import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_dart_knights_sih/core/errors/exceptions.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AWSApiClient awsApiClient;
  String username;
  String password;
  AuthCubit(
      {required this.awsApiClient,
      required this.username,
      required this.password})
      : super(AuthInitial()) {
    authenticateUser(email: username, password: password);
  }

  String authUserEmail = '';

  Future<void> authenticateUser(
      {required String email, required String password}) async {
    try {
      await awsApiClient.authenticateUser(email: email, password: password);
    } on CredentialsNotCorrectException {
      print("Credentials not correct");
      emit(CredentialsNotCorrect());
      return;
    }
    authUserEmail = email;
    emit(Authenticated());
  }

  Future<void> signOut() async {
    await awsApiClient.signOutUser(email: authUserEmail);
    emit(AuthInitial());
  }

  String get email {
    return authUserEmail;
  }
}
