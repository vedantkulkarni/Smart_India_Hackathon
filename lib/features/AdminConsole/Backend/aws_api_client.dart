import 'package:amazon_cognito_identity_dart_2/cognito.dart';

import '../../../models/User.dart';

abstract class AWSApiClient {
  Future<void> authenticateUser({required String email,required String password});
  Future<void> uploadUser();
  Future<void> getAdminDetails();
  
}

class AWSApiClientImpl implements AWSApiClient {
  @override
  Future<void> authenticateUser({required String email,required String password}) async{
     final userPool = CognitoUserPool(
      'ap-south-1_TAqXrMNgh',
      '5r2nk0dcq5gv6813j23289n9m8',
    );
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
    } on CognitoUserNewPasswordRequiredException {
      // handle New Password challenge
    } on CognitoUserMfaRequiredException {
      // handle SMS_MFA challenge
    } on CognitoUserSelectMfaTypeException {
      // handle SELECT_MFA_TYPE challenge
    } on CognitoUserMfaSetupException {
      // handle MFA_SETUP challenge
    } on CognitoUserTotpRequiredException {
      // handle SOFTWARE_TOKEN_MFA challenge 
    } on CognitoUserCustomChallengeException {
      // handle CUSTOM_CHALLENGE challenge
    } on CognitoUserConfirmationNecessaryException {
      // handle User Confirmation Necessary
    } on CognitoClientException {
      // handle Wrong Username and Password and Cognito Client
    } catch (e) {
      print(e);
    }
    print(session!.getAccessToken().getJwtToken());

        List<CognitoUserAttribute>? attributes;
try {
  attributes = await cognitoUser.getUserAttributes()!;
} catch (e) {
  print(e);
}
attributes!.forEach((attribute) {
  print('attribute ${attribute.getName()} has value ${attribute.getValue()}');
});

   
  }

  @override
  Future<User> getAdminDetails() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> uploadUser() {
    // TODO: implement uploadUser
    throw UnimplementedError();
  }
}
